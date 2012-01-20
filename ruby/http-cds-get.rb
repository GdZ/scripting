#!/usr/bin/ruby
require "rubygems"
require "curb"
require "getoptlong"
getoptlong = GetoptLong.new(
[ '--help', '-h', GetoptLong::NO_ARGUMENT ],
["--url", "-u",GetoptLong::REQUIRED_ARGUMENT],
["--speed", "-F",GetoptLong::OPTIONAL_ARGUMENT]
)
def usage()
	puts "Usage:"
	puts " [--help] [--speed 3.0] [--url url]"
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

# For some reason, when using sigle TCP connection, the second perform will hit Exeption
# So the solution is to use two connection
#
puts "URL  == #{url}"
puts "Speed == #{speed}"
#url = "http://U11-220-4.se.wmt.auto-sj5.com/snowboard_100.wmv"
#speed = 1.0
c0 = Curl::Easy.new("#{url}") do |curl|
   curl.headers["User-Agent"] = "NSPlayer/11.0.5721.5251"
   curl.follow_location = true
  # curl.headers["Connection"]="Keep-Alive"
  # curl.verbose = true
end
#c.on_body { |data| print "body"}
#c.on_header {|data| 
#	print(data)
#	}
#c0.on_complete { |conn| puts "on complete"}
c0.perform
if c0.response_code != 200
	print "HTTP return code is "+ c0.response_code.to_s + " exit\r\n"
	exit -1
else
	print "HTTP return code is 200, Good\r\n"
end
client_id = c0.header_str.scan(/client-id=(\d+)/).flatten[0]

puts "#{client_id} \r\n"
#c0.reset
#c = Curl::Easy.new()
c = c0.clone
c.url = "#{url}"
c.headers = ["User-Agent: NSPlayer/11.0.5721.5251"]
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
c.headers += ["Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=4294967295:4294967295,packet-num=4294967295,max-duration=0"]
#c.connect_timeout = 5;
c.on_body { |data| 
	print "Get One body with length: "+ data.length.to_s + "\r\n"
	if data.length == 8
		puts "Get End of stream msg \$E "
		c.reset
	else 
	end
	data.length
}

#c.headers["Connection"] = ''
c.on_header {|data| 
	print "HTTP Header: "+ data.chomp + "size of header is: " + data.length.to_s + "\r\n"
	data.length
}

c.perform
