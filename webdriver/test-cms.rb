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
#cdsm.get_co("flash-auto")
#cdsm.set_co("flashdemo","OriginFqdn","12.0.0.125")
#cdsm.get_co("flashdemo")
#cdsm.get_ds("we-sanity")
#cdsm.create_nas('Upload','uploadFile','C:\Documents and Settings\Administrator\My Documents\2.txt')
#cdsm.del_nas('2.txt')
#cdsm.modify_nas('2.txt','Upload','uploadFile','C:\Documents and Settings\Administrator\My Documents\2.txt','FileInfo_DestinationPath','2again.txt')
#cdsm.modify_nas('2again.txt','Upload','uploadFile','C:\Documents and Settings\Administrator\My Documents\2.txt','FileInfo_DestinationPath','2.txt')
#cdsm.create_nas('Import','FileInfo_OriginUrl','ftp://10.77.153.110/pub/Automation/NASCONFIG/NAS1.xml','FileInfo_DestinationPath','NAS1.xml','FileInfo_TTL','2')
#valid parameters for NAS
#hiddenconfigFileType

#textFileInfo_OriginUrl
#textFileInfo_DestinationPath
#textFileInfo_TTL
#textFileInfo_UserName
#passwordFileInfo_Password
#textFileInfo_Domain
#checkboxFileInfo_DisableBasicAuth
#hidden__checkbox_FileInfo_DisableBasicAuth

#cdsm.get_syscfg_list
sleep 3
cdsm.logout()
cdsm.teardown()


#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'ADD:NAS' --para 'Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt'
#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'DEL:NAS' --para '2.txt'
#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'SET:NAS' --para '2.txt,Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt,FileInfo_DestinationPath,2again.txt'
#./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 172.22.28.97 --brws ie --cmd 'GET:NAS' --para 'Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt'
#
#
#
