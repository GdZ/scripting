#!/usr/bin/ruby

require '/home/hailiang/workspace/scripting/ruby/cms_wb_api.rb'

#Login the CDSM
#

user = 'admin'
passwd = 'default'

unless ARGV.length == 1
	puts "Usage : .rb host-ip "
	exit
end
host = ARGV[0]
cdsm = CDSMWebDriver.new('firefox',host)
#cdsm = CDSMWebDriver.new('firefox','10.74.23.46')
cdsm.login(user,passwd)

