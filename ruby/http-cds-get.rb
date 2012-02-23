#!/usr/bin/ruby
##
## Copyright (c) 2012, Cisco Systems, Inc.
##
## Author: Herry Wang (hailwang@cisco.com)
## Not useful now. Need to be deleted
#
require "rubygems"
require "curb"
require "getoptlong"
getoptlong = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    ["--url", "-u",GetoptLong::REQUIRED_ARGUMENT],
    ["--speed", "-S",GetoptLong::OPTIONAL_ARGUMENT]
)
#url = "http://U11-220-4.se.wmt.auto-sj5.com/snowboard_100.wmv"
def usage()
    puts "Usage:"
    puts " [--help] [--speed 3.0] [--url url] or "
    puts " [--help] [-S 3.0] [-u url]"
end

if ARGV.empty?
    puts "invalid! URL is required"
    usage()
    puts
    exit
end
speed = 1.0  # declare local var to store arg
url = nil # declare local var to store arg

begin
    getoptlong.each do |opt, arg|
        case opt
        when "--help"
            puts "show help"
        when "--speed"
            print "Speed option. Arg is=>"
            print arg
            speed = arg
            print "<\n"
        when "--url"
            print "Url requested. Arg is=>"
            print arg
            url = arg
            print "<\n"
        end
    end
rescue StandardError=>my_error_message
    puts
    puts my_error_message
    usage()
    puts
    exit
end

#
#Now the CDS-IS Streamer Can't disconnect TCP it self after sending out EOS message to client
#For WMP player, when client receive EOS msg, it will disconnect TCP
#But for Curl.Easy, it's not possible to disconnect TCP to server actively.
#So client need wait for 2 mins(default) to be timeout.
#One solution is set timeout to less time, like 10s and capture the timeout error
#Another solution is use Async HTTP client, like em-http-request
#https://github.com/igrigorik/em-http-request
puts "URL  == #{url}"
puts "Speed == #{speed}"
c = Curl::Easy.new("#{url}") do |curl|
    curl.headers = ['User-Agent: NSPlayer/11.0.5721.5251']
    curl.headers += ['X-Accept-Authentication: Negotiate, NTLM, Digest, Basic']
    curl.headers += ['Pragma: version11-enabled=1']
    curl.headers += ['Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=0:0,packet-num=4294967295,max-duration=0']
    curl.headers += ['Pragma: packet-pair-experiment=1']
    curl.headers += ['Pragma: pipeline-experiment=1']
    curl.headers += ['Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm, com.microsoft.wm.startupprofilea']
    curl.headers += ['Accept-Language: en-US, *;q=0.1']
    curl.follow_location = true
    # curl.verbose = true
end
#Send first request
c.perform
if c.response_code != 200
    print "HTTP return code is "+ c.response_code.to_s + " exit\r\n"
    exit -1
else
    print "HTTP return code is 200, Good\r\n"
end
client_id = c.header_str.scan(/client-id=(\d+)/).flatten[0]
#Get client ID
puts "CLIENT ID is #{client_id} \r\n"
c.url = "#{url}"
c.timeout= 10
c.headers = ["User-Agent: NSPlayer/11.0.5721.5251"]
c.headers += ["Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=4294967295:4294967295,packet-num=4294967295,max-duration=0"]
if speed == 1.0 
    c.headers += ["Pragma: xPlayStrm=1","Pragma: LinkBW=2147483647\, AccelBW=2147483647\, AccelDuration=10000"]
else 
    c.headers += ["Pragma: xPlayStrm=1","Pragma: LinkBW=2147483647\, AccelBW=2147483647\, AccelDuration=10000, Speed=#{speed}"]
end
c.headers += ["Pragms: client-id=#{client_id}"]
c.headers += ["Supported: com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm"]
c.headers += ["Pragma: xClientGUID={3300AD50-2C39-46c0-AE0A-4FAB6317C555}"]
c.headers += ["Pragma: stream-switch-count=2"]
c.headers += ["Pragma: stream-switch-entry=ffff:1:0 ffff:2:0"]
c.headers += ["Accept-Language: en-us, *;q=0.1"]
c.on_body { |data| 
    print "Get One body with length: "+ data.length.to_s + "\r\n"
    if data.length == 8
        puts "Get End of stream msg \$E "
    else 
    end
    data.length
}

c.on_header {|data| 
    print "HTTP Header: "+ data.chomp + " Size of header is: " + data.length.to_s + "\r\n"
    data.length
}

c.perform
c.close
