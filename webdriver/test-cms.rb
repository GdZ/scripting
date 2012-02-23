#!/usr/bin/ruby
require "rubygems"
require './cms_wb_api.rb'

browser = 'ie'
#browser = 'firefox'
cdsm_url = 'https://U11-205-3:8443'
#cdsm_url = 'https://162.0.122.3:8443'
wd_ip = '172.22.28.97'
user = 'admin'
passwd = 'default'

#Login the CDSM
#


#Limitation for IE
#Due to certification issue, CDSM addr should be use fqdn, not ip.
#so hostname should be added into /etc/hosts file 

cdsm = CDSMWebDriver.new(wd_ip,browser,cdsm_url)
cdsm.login(user,passwd)
#CO
#cdsm.create_co('Name','test','OriginFqdn','1.2.3.4','Fqdn','cisco.com','ContentAffinityEnabled','0')
#cdsm.get_co("test",'Definition','OriginFqdn','Fqdn')
#cdsm.modify_co("test","OriginFqdn","12.0.0.125")
#cdsm.get_co("test",'Definition','OriginFqdn','Fqdn')
#cdsm.get_co("test",'Definition')
#cdsm.del_co("test")
#
#DS
#cdsm.create_ds('Name','test-ds','WebSiteId','test','CacheQuota','200')
#cdsm.create_ds('Name','test-ds','ContentOriginId','test','CacheQuota','200')
#cdsm.assign_se('test-ds','','U11-205-5','U11-220-3')
#cdsm.assign_se('test-ds','U11-205-5','U11-205-5','U11-220-3')
#cdsm.get_ds("test-ds",'Definition')
#cdsm.modify_ds('test-ds','Definition','CacheQuota','500')
#cdsm.get_ds("test-ds",'Definition','SkipEncryption','DeliveryQos','CacheQuota')
#cdsm.get_ds("test-ds",'General Settings','Bitrate','HttpExt')
#cdsm.del_ds('test-ds')
#cdsm.del_co("test")

#NAS
#
#
#cdsm.create_nas('method','Upload','uploadFile','C:\Documents and Settings\Administrator\My Documents\pub\automation\testcase\feature\NAS\NAS-UPLOAD\NAS-valid.xml')
#cdsm.create_nas('Upload','uploadFile','C:\Documents and Settings\Administrator\My Documents\2.txt')
#cdsm.modify_nas('NAS-valid.xml','method','Upload','uploadFile','C:\Documents and Settings\Administrator\My Documents\pub\automation\testcase\feature\NAS\NAS-UPLOAD\NAS1-valid.xml','FileInfo_DestinationPath','NAS1-valid.xml')
#cdsm.del_nas('NAS1-valid.xml')
#cdsm.create_nas('method','Import','FileInfo_OriginUrl','ftp://10.77.153.110/pub/Automation/NASCONFIG/NAS1.xml','FileInfo_DestinationPath','NAS1.xml','FileInfo_TTL','2')
#cdsm.get_syscfg_list
#
#
#cdsm.create_program('name','test','serviceType','Windows Media Live','AutoDelete','1')
#cdsm.get_program('test','Live Streaming')
#cdsm.get_program('test','Definition')
#cdsm.get_program('test','Select Live Delivery Service')
#cdsm.get_program('test','Schedule')
#cdsm.modify_program('test','Select Live Delivery Service','chSelect','0')
#cdsm.modify_program('test','Live Streaming','liveSrc','http://1.2.3.4:8089','ucast','1','ucastUrl','http://wmt.auto-sj5.com/test.asx')
#cdsm.modify_program('test','Schedule','schedOrNot','1','startMonth','February','startDay','26','repeatOrNot','1')
#cdsm.create_dg('Name','test','Role','1','webgroup','1')
#cdsm.assign_dg('test','U11-205-5','U11-220-4')
#cdsm.del_dg('test')
cdsm.logout()
sleep 5
cdsm.teardown()


#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'ADD:NAS' --para 'Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt'
#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'DEL:NAS' --para '2.txt'
#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'SET:NAS' --para '2.txt,Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt,FileInfo_DestinationPath,2again.txt'
#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'GET:NAS' --para 'Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt'
#
#
#
