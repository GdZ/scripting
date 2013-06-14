#!/usr/bin/ruby
require "rubygems"
require "getoptlong"
getoptlong = GetoptLong.new(
[ '--help', '-h', GetoptLong::NO_ARGUMENT ],
["--cdsm", "-C",GetoptLong::REQUIRED_ARGUMENT],
["--wdip", "-w",GetoptLong::REQUIRED_ARGUMENT],
["--cmd", "-m",GetoptLong::REQUIRED_ARGUMENT],
["--para", "-P",GetoptLong::REQUIRED_ARGUMENT],
["--brws", "-W",GetoptLong::OPTIONAL_ARGUMENT]
)
def usage()
	puts "Usage:"
	puts " [--help] [--cdsm https://1.2.3.4:8443] [--wdip 2.3.4.5 ] [--brws ie]"
	puts " [--help] [--cmd ADD:NAS] [--para 'a,b,c,d']"
    puts " cmd: Action includes: ADD,DEL,SET,GET,ASS"
    puts " cmd: Object includes: CO,DS,NAS,DG,PROGRAM,SE"
    puts " for example: assign se, 'ASS:SE'"
    puts " --para format: if action is ADD, key/value pairs"
    puts " if action is GET/SET, first parameter is the object name followed by key/value pairs"
    puts " if action is DEL,parameter is the object name"
    puts " when action is ASS:SE, first one is the object name, followed by ACQ SE,and list of SE"
    puts " when action is ASS:DG, first one is the object name, followed by list of SE"

end

if ARGV.empty?
   puts "invalid! URL is required"
   usage()
   puts
   exit
end

browser = 'ie'
cdsm_url = 'https://U11-205-3:8443'
wd_ip = '172.22.28.97'
user = 'admin'
passwd = 'default'
cmd_name = ''
cmd_obj = 'nas'
cmd_p = []
cmd_str = ''
begin
	getoptlong.each do |opt, arg|
		case opt
			when "--help"
				puts "show help"
			when "--cdsm"
				print "cdsm URL. Arg is=>"
				print arg
				cdsm_url = arg
				print "<\n"
			when "--wdip"
				print "Url requested. Arg is=>"
				print arg
				wd_ip = arg
				print "<\n"
			when "--brws"
				print "Browser type. Arg is=>"
                print arg
				browser = arg
				print "<\n"
            when "--cmd"
                puts arg
                cmd = arg.split(':')
                cmd_name = cmd[0]
                cmd_obj = cmd[1]
            when "--para"
                puts arg
                cmd_p = arg.split(',')
		end
	end
rescue StandardError=>my_error_message
	puts
	puts my_error_message
	usage()
	puts
	exit
end

require './cms_wb_api.rb'

#Login the CDSM
#


if cmd_name == 'ADD'
    cmd_str = 'cdsm.' + 'create'
elsif cmd_name == 'DEL'
    cmd_str = 'cdsm.' + 'del'
elsif cmd_name == 'SET'
    cmd_str = 'cdsm.' + 'modify'
elsif cmd_name == 'GET'
    cmd_str = 'cdsm.' + 'get'
elsif cmd_name == 'ASS'
    cmd_str = 'cdsm.' + 'assign'
end

cmd_obj.downcase!
cmd_str = cmd_str +  '_' + cmd_obj + '('
#cdsm.get_co(

cmd_p.each do |p|
    p = "'" + p + "'"
    cmd_str = cmd_str + p + ','
end
cmd_str = cmd_str.chop + ')'
puts "CMD STR : " + cmd_str

#Limitation for IE
#Due to certification issue, CDSM addr should be use fqdn, not ip.
#so hostname should be added into /etc/hosts file 

#cdsm = CDSMWebDriver.new('172.22.28.97','firefox','https://162.0.122.3:8443')
cdsm = CDSMWebDriver.new(wd_ip,browser,cdsm_url)
cdsm.login(user,passwd)
eval cmd_str
cdsm.logout()
#wait for 5 s, Make sure teardown is fine.
sleep 5
cdsm.teardown()
