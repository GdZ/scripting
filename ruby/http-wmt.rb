#!/usr/bin/ruby
##
## Copyright (c) 2012, Cisco Systems, Inc.
##
## Author: Herry Wang (hailwang@cisco.com)
##
#
require "rubygems"
require "curb"
require "xmlsimple"
class HttpWMTGet
   attr_accessor :speed,:url,:duration,:verbose,:logstat,:client_id
   def initialize(url)

      @speed = 1.0  # declare local var to store arg
      @url = url # declare local var to store arg
      @duration = 999
      @verbose = false 
      @logstat = true
      @total_bytes  = 0
      @total_packets = 0
      @client_id = ''
      @asxfile = true if /\.asx$/ =~ url
      @post_log = true
   end
   def speed=(s)
      @speed = s
   end
   def duration=(d)
      @duration=d
   end
   def verbose=(v)
      @verbose = v
   end
   def url=(u)
      @url = u
   end

   #
   #Windows Media Player will disconnect TCP actively when receiving EOS.
   #For this client, WMS will close TCP right after EOS msg. (Why ?), so client don't have to close connection explicitly
   #But CDS-IS Streamer Can't disconnect TCP it self after sending out EOS message to client,
   # streamer will send keep-alive to client after 90s. 30s later, client close connection.
   #But for Curl.Easy, it's not possible to disconnect TCP to server actively.
   #So client need wait for 2 mins(default) to be timeout.
   #One solution is set timeout to less time, like 10s and capture the timeout error
   #Another solution is use Async HTTP client, like em-http-request
   # https://github.com/igrigorik/em-http-request
   #
   #Update: curb do support Multile interfaces !
   #So the idea is: using Easy one to send the first request, then add this one into multil so that we can monitor this socket
   #
   #Update: There is issue when using Multiple interface:
   # New connection will be created, instead of using the existing one. set pipeline doesn't help
   # It's working well with C language. 
   # It works perfectly on C.
   #
   #Update: Curb author's comments. 
   #https://github.com/taf2/curb/issues/108#issuecomment-4054668
   #Using 3 easy interfaces, 2 Get + 1 Post
   #To fix the abort issue, just return -1 in on_body and capture one exception.

   def do_download()
      puts "URL  == #{@url}"
      puts "Speed == #{@speed}"
      c = Curl::Easy.new("#{@url}") do |curl|
         curl.headers= ['User-Agent: NSPlayer/11.0.5721.5251']
         curl.headers+= ['X-Accept-Authentication: Negotiate, NTLM, Digest, Basic']
         curl.headers+= ['Pragma: version11-enabled=1']
         curl.headers+= ['Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=0:0,packet-num=4294967295,max-duration=0']
         curl.headers+= ['Pragma: packet-pair-experiment=1']
         curl.headers+= ['Pragma: pipeline-experiment=1']
         curl.headers+= ['Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm, com.microsoft.wm.startupprofilea']
         curl.headers+= ['Accept-Language: en-US, *;q=0.1']
         #curl.follow_location = true
         # curl.verbose = true
      end

      c.on_body { |data| 
         print "Get One body with length: "+ data.length.to_s + "\r\n"
         data.length
      }
      #Send first request to get client_id
      c.perform
      #@url = c.last_effective_url
      #puts "last effetive url is " + @url
      if c.response_code == 302
         @url = c.header_str.scan(/Location:\s+(.*)\r\n/).flatten[0]
         c.close
         c = Curl::Easy.new("#{@url}") do |curl|
            curl.headers= ['User-Agent: NSPlayer/11.0.5721.5251']
            curl.headers+= ['X-Accept-Authentication: Negotiate, NTLM, Digest, Basic']
            curl.headers+= ['Pragma: version11-enabled=1']
            curl.headers+= ['Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=0:0,packet-num=4294967295,max-duration=0']
            curl.headers+= ['Pragma: packet-pair-experiment=1']
            curl.headers+= ['Pragma: pipeline-experiment=1']
            curl.headers+= ['Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm, com.microsoft.wm.startupprofilea']
            curl.headers+= ['Accept-Language: en-US, *;q=0.1']
            #curl.follow_location = true
            # curl.verbose = true
         end
         c.perform
      end
      if c.response_code != 200
         print "HTTP return code is "+ c.response_code.to_s + " exit\r\n"
         #@post_log = false
         #return -1
         exit -1
      else
         print "HTTP return code is 200, Good\r\n"
      end
      content_len = '0'
      content_len = c.header_str.scan(/Content-Length:\s+(\d+)/).flatten[0]
      @client_id = c.header_str.scan(/client-id=(\d+)/).flatten[0]
      #Get client ID
      puts "CLIENT ID is #{@client_id} "
      #puts "Content-Length is #{content_len}"

      c.headers = ["User-Agent: NSPlayer/11.0.5721.5251"]
      c.headers += ["Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=4294967295:4294967295,packet-num=4294967295,max-duration=0"]
      if @speed == 1.0 
         c.headers += ["Pragma: xPlayStrm=1","Pragma: LinkBW=2147483647\, AccelBW=2147483647\, AccelDuration=10000"]
      else 
         c.headers += ["Pragma: xPlayStrm=1","Pragma: LinkBW=2147483647\, AccelBW=2147483647\, AccelDuration=10000, Speed=#{@speed}"]
      end
      c.headers += ["Pragms: client-id=#{@client_id}"]
      c.headers += ["Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm"]
      c.headers += ["Pragma: xClientGUID={3300AD50-2C39-46c0-AE0A-4FAB6317C555}"]
      c.headers += ["Pragma: stream-switch-count=2"]
      c.headers += ["Pragma: stream-switch-entry=ffff:1:0 ffff:2:0"]
      c.headers += ["Accept-Language: en-us, *;q=0.1"]
      @total_packets = 0
      c.on_body { |data| 
         if @verbose
            print "Get One body with length: "+ data.length.to_s + "\r\n"
         end
         print "#"
         @total_bytes += data.length
         @total_packets += 1
         #End of Stream $E
         if c.total_time > @duration
            puts "We are going to close the socket to Server"
            -1
         elsif data.length == 8 && data == "\x24\x45\x04\x00\x00\x00\x00\x00"
            puts "\r\nGet End of stream msg \$E "
            -1
         else 
            data.length
         end
      }
      c.on_header {|data| 
         print "HTTP Header: "+ data.chomp + " Size of header is: " + data.length.to_s + "\r\n"
         if data =~ /Content-Length/
            @post_log = false
         end
         data.length
      }

      begin
         c.http_get
      rescue Curl::Err::WriteError => e
         puts e.message
      end

      puts "Sumary : Total bytes  " + @total_bytes.to_s + " Total packets " + @total_packets.to_s

   end

   def post_log 
      if @post_log == false
         return 
      end
      log_xml_data =  <<XML_STR
    <XML>
    <Summary>0.0.0.0 2012-01-10 21:46:38 - http://wmt-os.auto.com:8800/pinball.wmv 0 2 5 200 {3300AD50-2C39-46c0-AE0A-8692EAFE4CA1} 11.0.5721.5275 en-US WMFSDK/11.0.5721.5275_WMPlayer/11.0.5721.5280 - wmplayer.exe 11.0.5721.5145 Windows_XP 5.1.0.2600 Pentium 22 836560 3054307 http TCP - - - - 836879 - 549 0 0 0 0 0 0 1 0 100 - - - - http://wmt-os.auto.com:8800/pinball.wmv pinball.wmv - </Summary>
    <c-ip>0.0.0.0</c-ip>
    <date>2012-01-10</date>
    <time>21:46:38</time>
    <c-dns>-</c-dns>
    <cs-uri-stem>http://wmt-os.auto.com:8800/pinball.wmv</cs-uri-stem>
    <c-starttime>0</c-starttime>
    <x-duration>2</x-duration>
    <c-rate>5</c-rate>
    <c-status>200</c-status>
    <c-playerid>{3300AD50-2C39-46c0-AE0A-8692EAFE4CA1}</c-playerid>
    <c-playerversion>11.0.5721.5275</c-playerversion>
    <c-playerlanguage>en-US</c-playerlanguage>
    <cs-User-Agent>WMFSDK/11.0.5721.5275_WMPlayer/11.0.5721.5280</cs-User-Agent>
    <cs-Referer>-</cs-Referer>
    <c-hostexe>wmplayer.exe</c-hostexe>
    <c-hostexever>11.0.5721.5145</c-hostexever>
    <c-os>Windows_XP</c-os>
    <c-osversion>5.1.0.2600</c-osversion>
    <c-cpu>Pentium</c-cpu>
    <filelength>22</filelength>
    <filesize>836560</filesize>
    <avgbandwidth>3054307</avgbandwidth>
    <protocol>http</protocol>
    <transport>TCP</transport>
    <audiocodec>-</audiocodec>
    <videocodec>-</videocodec>
    <c-channelURL>-</c-channelURL>
    <sc-bytes>-</sc-bytes>
    <c-bytes>836879</c-bytes>
    <s-pkts-sent>-</s-pkts-sent>
    <c-pkts-received>549</c-pkts-received>
    <c-pkts-lost-client>0</c-pkts-lost-client>
    <c-pkts-lost-net>0</c-pkts-lost-net>
    <c-pkts-lost-cont-net>0</c-pkts-lost-cont-net>
    <c-resendreqs>0</c-resendreqs>
    <c-pkts-recovered-ECC>0</c-pkts-recovered-ECC>
    <c-pkts-recovered-resent>0</c-pkts-recovered-resent>
    <c-buffercount>1</c-buffercount>
    <c-totalbuffertime>0</c-totalbuffertime>
    <c-quality>100</c-quality>
    <s-ip>-</s-ip>
    <s-dns>-</s-dns>
    <s-totalclients>-</s-totalclients>
    <s-cpu-util>-</s-cpu-util>
    <cs-url>http://wmt-os.auto.com:8800/pinball.wmv</cs-url>
    <ContentDescription>
    <title>Pinball_WM_9_Series</title>
    <author>Microsoft_Corporation</author>
    <copyright>Copyright_(C)_Microsoft_Corporation._All_rights_reserved.</copyright>
    <WMS_CONTENT_DESCRIPTION_SERVER_BRANDING_INFO>WMServer/9.1</WMS_CONTENT_DESCRIPTION_SERVER_BRANDING_INFO>
    <WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_START_OFFSET>3000</WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_START_OFFSET>
    <WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_DURATION>21833</WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_DURATION>
    <WMS_CONTENT_DESCRIPTION_COPIED_METADATA_FROM_PLAYLIST_FILE>1</WMS_CONTENT_DESCRIPTION_COPIED_METADATA_FROM_PLAYLIST_FILE>
    <WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_URL>pinball.wmv</WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_URL>
    </ContentDescription>
    </XML>
XML_STR
    summary_text = ''

        log_hash = XmlSimple.xml_in log_xml_data , {'ForceArray' => false,'AttrPrefix' => true}
        t = Time.now.utc
        #http://ruby-doc.org/core-1.9.3/Time.html#method-i-strftime
        log_hash['c-ip'] = '0.0.0.0'
        summary_text += ' ' + log_hash['c-ip']
        #
        log_hash['date'] = t.strftime("%Y-%m-%d")
        summary_text += ' ' + log_hash['date']
        #
        log_hash['time'] = t.strftime("%H:%M:%S")
        summary_text += ' ' + log_hash['time']
        log_hash['c-dns'] = '-'
        summary_text += ' ' + log_hash['c-dns']
        #
        log_hash['cs-uri-stem'] = @url
        summary_text += ' ' + log_hash['cs-uri-stem']
        #?
        log_hash['x-duration'] = '2'
        summary_text += ' ' + log_hash['x-duration']
        # speed ?
        log_hash['c-rate'] = @speed.to_i.to_s
        summary_text += ' ' + log_hash['c-rate']
        log_hash['c-status'] = '200'
        summary_text += ' ' + log_hash['c-status']
        log_hash['c-playerid'] = '{3300AD50-2C39-46c0-AE0A-4FAB6317C555}'
        summary_text += ' ' + log_hash['c-playerid']
        log_hash['c-playerversion'] = '11.0.5721.5275'
        summary_text += ' ' + log_hash['c-playerversion']
        log_hash['c-playerlanguage'] = 'en-US'
        summary_text += ' ' + log_hash['c-playerlanguage']
        log_hash['cs-User-Agent'] = 'WMFSDK/11.0.5721.5275_WMPlayer/11.0.5721.5280'
        summary_text += ' ' + log_hash['cs-User-Agent']
        log_hash['cs-Referer'] = '-'
        summary_text += ' ' + log_hash['cs-Referer']
        log_hash['c-hostexe'] = 'wmplayer.exe'
        summary_text += ' ' + log_hash['c-hostexe']
        log_hash['c-hostexever'] = '11.0.5721.5145'
        summary_text += ' ' + log_hash['c-hostexever']
        log_hash['c-os'] = 'Windows_XP'
        summary_text += ' ' + log_hash['c-os']
        log_hash['c-osversion'] = '5.1.0.2600'
        summary_text += ' ' + log_hash['c-osversion']
        log_hash['c-cpu'] = 'Pentium'
        summary_text += ' ' + log_hash['c-cpu']
        # ? duration ?
        log_hash['filelength'] = '22'
        summary_text += ' ' + log_hash['filelength']
        # total sizes 
        log_hash['filesize'] = @total_bytes.to_s
        summary_text += ' ' + log_hash['filesize']
        log_hash['avgbandwidth'] ='3054307'
        summary_text += ' ' + log_hash['avgbandwidth']
        #Protocol 
        log_hash['protocol'] = 'http'
        summary_text += ' ' + log_hash['protocol']
        log_hash['transport'] = 'TCP'
        summary_text += ' ' + log_hash['transport']
        log_hash['audiocodec'] = '-'
        summary_text += ' ' + log_hash['audiocodec']
        log_hash['videocodec'] = '-'
        summary_text += ' ' + log_hash['videocodec']
        log_hash['c-channelURL'] ='-'
        summary_text += ' ' + log_hash['c-channelURL']
        log_hash['sc-bytes'] = '-'
        summary_text += ' ' + log_hash['sc-bytes']
        # total size, actually it's a little bit diff with filesize, not sure how to get it
        log_hash['c-bytes'] = @total_bytes.to_s
        summary_text += ' ' + log_hash['c-bytes']
        log_hash['s-pkts-sent'] = '-'
        summary_text += ' ' + log_hash['s-pkts-sent']
        # packets number
        log_hash['c-pkts-received'] = @total_packets.to_s
        summary_text += ' ' + log_hash['c-pkts-received']
        log_hash['c-pkts-lost-client'] = '0'
        summary_text += ' ' + log_hash['c-pkts-lost-client']
        log_hash['c-pkts-lost-net'] = '0'
        summary_text += ' ' + log_hash['c-pkts-lost-net']
        log_hash['c-pkts-lost-cont-net'] ='0'
        summary_text += ' ' + log_hash['c-pkts-lost-cont-net']
        log_hash['c-resendreqs'] = '0'
        summary_text += ' ' + log_hash['c-resendreqs']
        log_hash['c-pkts-recovered-ECC'] = '0'
        summary_text += ' ' + log_hash['c-pkts-recovered-ECC']
        log_hash['c-pkts-recovered-resent'] = '0'
        summary_text += ' ' + log_hash['c-pkts-recovered-resent']
        log_hash['c-buffercount'] = '1'
        summary_text += ' ' + log_hash['c-buffercount']
        log_hash['c-totalbuffertime'] = '0'
        summary_text += ' ' + log_hash['c-totalbuffertime']
        log_hash['c-quality'] = '100'
        summary_text += ' ' + log_hash['c-quality']
        log_hash['s-ip'] = '-'
        summary_text += ' ' + log_hash['s-ip']
        log_hash['s-dns'] = '-'
        summary_text += ' ' + log_hash['s-dns']
        log_hash['s-totalclients'] = '-'
        summary_text += ' ' + log_hash['s-totalclients']
        log_hash['s-cpu-util'] = '-'
        summary_text += ' ' + log_hash['s-cpu-util']
        #currently set it to url, not sure it will be recorded as redirected one.
        log_hash['cs-url'] = url
        summary_text += ' ' + log_hash['cs-url']
        log_hash['ContentDescription']['title'] = 'HERRY-TEST'
        #log_hash['ContentDescription']['title'] = 'Pinball_WM_9_Series'
        log_hash['ContentDescription']['author'] = 'Herry Wang'
        #log_hash['ContentDescription']['author'] = 'Microsoft_Corporation'
        log_hash['ContentDescription']['copyright'] = 'Cisco Systems Corp'
        #log_hash['ContentDescription']['copyright'] = 'Copyright_(C)_Microsoft_Corporation._All_rights_reserved.'
        log_hash['ContentDescription']['WMS_CONTENT_DESCRIPTION_SERVER_BRANDING_INFO'] = 'HERRY-TEST'
        #log_hash['ContentDescription']['WMS_CONTENT_DESCRIPTION_SERVER_BRANDING_INFO'] = 'WMServer/9.1'
        log_hash['ContentDescription']['WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_START_OFFSET'] = '3000'
        log_hash['ContentDescription']['WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_DURATION'] = '21833'
        log_hash['ContentDescription']['WMS_CONTENT_DESCRIPTION_COPIED_METADATA_FROM_PLAYLIST_FILE'] = '1'
        log_hash['ContentDescription']['WMS_CONTENT_DESCRIPTION_PLAYLIST_ENTRY_URL'] = 'pinball.wmv'

        log_hash['Summary'] = summary_text
        #p log_hash
        doc = REXML::Document.new XmlSimple.xml_out(log_hash,'RootName' => 'XML','AttrPrefix' => true,'Indent' => " ")
        #doc = REXML::Document.new XmlSimple.xml_out(log_hash,'RootName' => 'XML','AttrPrefix' => true,'NoIndent' => true)
        log_stats_data = ''
        doc.write(log_stats_data)
        log_stats_data = "\n" + log_stats_data
        log_stats_data.chomp!
        #puts log_stats_data

        #sending out using post
        c2 = Curl::Easy.http_post("#{url}") do |curl|
            curl.headers = ["Pragma: client-id=#{client_id}"]
            #curl.headers += ["Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm"]
            #curl.headers += ["Pragma: xClientGUID={3300AD50-2C39-46c0-AE0A-4FAB6317C555}"]
            curl.headers += ['User-Agent: NSPlayer/11.0.5721.5251']
            curl.headers += ['Content-Type: application/x-wms-LogStats;charset=UTF-8']
            curl.headers += ['X-Accept-Authentication: Negotiate,NTLM, Digest, Basic']
            curl.post_body = log_stats_data
            curl.headers += ["Expect:"]
            #curl.multipart_form_post = true
            #curl.follow_location = true
        end

        puts "POST Response code is " + c2.response_code.to_s
        puts "POST Response Header " + c2.header_str

    end

end
