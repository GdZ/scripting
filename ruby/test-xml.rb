#!/usr/bin/ruby
###
### Copyright (c) 2012, Cisco Systems, Inc.
###
### Author: Herry Wang (hailwang@cisco.com)
###
##
require "rubygems"
require "curb"
require "xmlsimple"

#http://xml-simple.rubyforge.org/
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


log_hash = XmlSimple.xml_in log_xml_data , {'ForceArray' => false,'AttrPrefix' => true}
#log_hash = XmlSimple.xml_in log_xml_data , {'ForceArray' => false, 'KeepRoot' => true}
p log_hash
log_hash['date'] = '2015-3-2'
doc = REXML::Document.new XmlSimple.xml_out(log_hash,'RootName' => 'XML','AttrPrefix' => true)
d = ''
doc.write(d)
puts d
#c = Curl::Easy.http_post("http://wmt-os.auto-sj5.com",
#                         Curl::PostField.content('wmt_live', d))
#c.headers['Content-Type'] = 'application/x-wms-LogStats;charset=UTF-8'
#
#
#
#POST /wmt_live HTTP/1.0
#
#Accept: */*
#
#User-Agent: NSPlayer/11.0.5721.5251
#
#Host: v11-205-7.se.wmtlive.auto-wmtauto2.com
#
#Pragma: xClientGUID={3300AD50-2C39-46c0-AE0A-1793787BA5B8}
#
#X-Accept-Authentication: Negotiate, NTLM, Digest, Basic
#
#Pragma: client-id=1995306634
#
#Content-Length: 2778
#
#Content-Type: application/x-wms-LogStats;charset=UTF-8
c = Curl::Easy.http_post("http://wmt-os.auto-sj5.com/wmt_live") do |curl|
    curl.headers = ["Pragms: client-id=12345"]
    curl.headers += ["Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm"]
    curl.headers += ["Pragma: xClientGUID={3300AD50-2C39-46c0-AE0A-4FAB6317C555}"]
    curl.headers += ['User-Agent: NSPlayer/11.0.5721.5251']
    curl.headers += ['Content-Type: application/x-wms-LogStats;charset=UTF-8']
    curl.headers += ['X-Accept-Authentication: Negotiate,NTLM, Digest, Basic']
    curl.post_body = d
    curl.headers += ["Expect:"]
    #curl.multipart_form_post = true
    #curl.follow_location = true
end
#c.perform
