#!/usr/bin/ruby
##
## Copyright (c) 2012, Cisco Systems, Inc.
##
## Author: Herry Wang (hailwang@cisco.com)
##
#
require "em-http-request"
headers = Hash.new
headers['User-Agent'] = 'NSPlayer/11.0.5721.5251'
headers['X-Accept-Authentication'] = 'Negotiate, NTLM, Digest, Basic'
headers['Pragma'] ='no-cache,rate=1.000,stream-time=0,stream-offset=0:0,packet-num=4294967295,max-duration=0' + "\r\n" +'Pragma: packet-pair-experiment=1' +"\r\n"+ 'Pragma: pipeline-experiment=1' + "\r\n"+ 'Pragma: version11-enabled=1'
headers['Supported'] = 'com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm, com.microsoft.wm.startupprofilea'
headers['Accept-Language']= 'en-US, *;q=0.1'

speed = 5.0
EventMachine.run {
	http = EventMachine::HttpRequest.new('http://U11-220-3.se.wmt.auto-sj5.com/pinball.wmv')
	request_option = {:head => headers, :keepalive => true}
		req1 = http.get request_option
			req1.stream { |chunk| puts "Got one msg"  }
		req1.errback { p 'Uh oh'; EM.stop }
	req1.callback {
		p req1.response_header.status
			p req1.response_header

			client_id = req1.response_header.to_s.scan(/client-id=(\d+)/).flatten[0]
			header2 = Hash.new
			header2['User-Agent'] = 'NSPlayer/11.0.5721.5251'
			header2['X-Accept-Authentication'] = 'Negotiate, NTLM, Digest, Basic'
			header2['Supported'] = 'com.microsoft.wm.srvppair, com.microsoft.wm.sswitch, com.microsoft.wm.predstrm'
			header2['Accept-Language']= 'en-US, *;q=0.1'
			pragma = ["Pragma: no-cache,rate=1.000,stream-time=0,stream-offset=4294967295:4294967295,packet-num=4294967295,max-duration=0"]
			if speed == 1.0 
				pragma += ["Pragma: LinkBW=2147483647\, AccelBW=2147483647\, AccelDuration=10000"]
			else 
				pragma += ["Pragma: LinkBW=2147483647\, AccelBW=2147483647\, AccelDuration=10000, Speed=#{speed}"]
					end
					pragma += ["Pragms: client-id=#{client_id}"]
					pragma += ["Pragma: xClientGUID={3300AD50-2C39-46c0-AE0A-4FAB6317C555}"]
					pragma += ["Pragma: stream-switch-count=2"]
					pragma += ["Pragma: stream-switch-entry=ffff:1:0 ffff:2:0"]
					pragma_other = pragma.inject('') { |all,single| all + "\r\n" + single }

			pragma_other = 'xPlayStrm=1' + pragma_other
		header2['Pragma'] = pragma_other

			request_option2 = {:head => header2, :keepalive => true}
			req2 = http.get request_option2 
			req2.stream { |chunk| puts "Got2 one msg"  }
			req2.errback { p 'Uh oh'; EM.stop }
		req2.callback {
			
			p req2.response_header.status
				p req2.response_header
			data = req2.response.to_s
			puts "DATA Len " + req2.response.length.to_s
			if data.length == 8 && data == "\x24\x45\x04\x00\x00\x00\x00\x00"
				EventMachine.stop
			end
				EventMachine.stop

		}

	}
}
