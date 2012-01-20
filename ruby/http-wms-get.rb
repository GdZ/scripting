require "rubygems"
require "curb"

c = Curl::Easy.new("http://172.22.30.141:8800/pinball.wmv") do |curl|
   curl.headers["User-Agent"] = "NSPlayer"
   curl.headers["Connection"]="Keep-Alive"
   curl.verbose = true
end
c.on_body { |data| print(data)}
c.on_header {|data| print(data)}
c.perform
c.url = "http://172.22.30.141:8800/pinball.wmv"
c.headers["Pragma"]="xPlayStrm=1"
c.perform


