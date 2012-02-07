
Release of  prototype version for CDSM/NAS configuration using selenium.
You can integrate it with test automation framework.

1)  Login client Linux box, 172.22.28.19, with login hailwang/hailwang
2)  Cd ~/tmp.  ( will change it later)
3)  Execute following commands to do what you want.
4)  
ruby ./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 154.0.102.7 --brws ie --cmd 'ADD:NAS' --para 'Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt'
ruby ./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 154.0.102.7 --brws ie --cmd 'ADD:NAS' --para 'Import,FileInfo_OriginUrl,ftp://10.77.153.110/pub/Automation/NASCONFIG/NAS1.xml,FileInfo_DestinationPath,NAS1.xml,FileInfo_TTL,2.
ruby ./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 154.0.102.7 --brws ie --cmd 'DEL:NAS' --para '2.txt'
ruby ./cdsm-cmd.rb --cdsm 'https://u11-205-3:8443' --wdip 154.0.102.7 --brws ie --cmd 'SET:NAS' --para '2.txt,Upload,uploadFile,C:\Documents and Settings\Administrator\My Documents\2.txt,  FileInfo_DestinationPath,2again.txt'

If you want it to configure another CDSM, pls make sure:
a)  If you wanna set browser type to IE, you have to use cdsm hostname to login, avoiding certification issue. Firefox is fine.
When hostname is used, you may add hostname into /etc/hosts in windows PC 154.0.102.7
b)  For NAS, 2 kinds of operation are supported. ADD, DEL, SET. 
Documentation is not done yet. Pls follow these 4 samples first.


IE-driver is vulnerable to be crashing when you didn.t configure it right.
I saw 6 IE was opened and  2 of them showed  wrong domain name.  I guess at that time u111-205-3 was not added into /etc/hosts. Then IE-driver crashed, so you got Connection refuse msg.

Now IE-driver has been started and you can try it again.  When you hit the same issue, pls login to 154.0.102.7 to start selenium-server .

c:\clients>java -jar selenium-server-standalone-2.17.0.jar
