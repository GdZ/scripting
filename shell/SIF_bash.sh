#!/bin/bash
#This tool is used to build SIF
#Before run it, please change the VMS,Magento, Conductor info first. 

echo "STEP1: modify web.xml"
v2="param-value"
filter1="Dev"
v3="Dev,Memcached,Interceptor-Enabled,Interceptor-Default"
path1=`dirname $0`
#path1="/root/SIF_2_0_1"
file1="VR5SIF/src/main/webapp/WEB-INF/web.xml"
#file1="VR5SIF/src/main/webapp/WEB-INF/test.xml"
echo "Change properties file : Localcache to Memcached"

cd $path1 
# Creating a temporary file for sed to write the changes to
temp_file="repl.temp"
 
# Elegance is the key -> adding an empty last line for Mr. .sed. to pick up
echo " " >> $file1 
 
el_value=`grep "<$v2>.*<.$v2>" $file1 |grep $filter1 | sed -e "s/^.*<$v2/<$v2/" | cut -f2 -d">"| cut -f1 -d "<"`
 
echo "Found the current value for the element <$v2> of valure '$el_value'"
 
sed -e "s/<$v2>$el_value<\/$v2>/<$v2>$v3<\/$v2>/g" $file1 > $temp_file
diff $temp_file $file1
mv $temp_file $file1

echo "STEP2: modify hosts "

file2="VR5SIF/src/main/resources/META-INF/spring/config/reference/Dev/API-RPC-hosts-Dev.properties"
#file2="VR5SIF/src/main/resources/META-INF/spring/config/reference/Dev/API-RPC-hosts-Dev.properties.test"
key1="vms.host"
vms1="http://vs-centos-13.cisco.com:80"
sed -i "s#$key1=.*#$key1=$vms1#" $file2
key2="vms.sm.host"
vms2="http://vs-centos-13.cisco.com:80"
sed -i "s#$key2=.*#$key2=$vms2#" $file2
key3="vms.em.host"
vms3="http://vs-centos-13.cisco.com:80"
sed -i "s#$key3=.*#$key3=$vms3#" $file2
key4="magento.host"
magento1="http://ss-auto-centos-4.cisco.com:80"
sed -i "s#$key4=.*#$key4=$magento1#" $file2
key5="memcached.servers"
memcache1="172.29.96.99:11211"
sed -i "s#$key5=.*#$key5=$memcache1#" $file2

echo "STEP3: modify affilicatedid "

file3="VR5SIF/src/main/resources/META-INF/spring/domain/domain-configuration.properties"
#file3="VR5SIF/src/main/resources/META-INF/spring/domain/domain-configuration.properties.test"
key6="vms.affiliateId"
vmsaff="b9253d2b-23d2-4a68-ba1f-896ea0f95485"
sed -i "s#$key6=.*#$key6=$vmsaff#" $file3

echo "STEP4: modify conductor"

file4="VR5SIF/src/main/resources/META-INF/spring/CD/cd-xmppuser-config.properties"
#file4="VR5SIF/src/main/resources/META-INF/spring/CD/cd-xmppuser-config.properties.test"
key7="sif.jid"
key8="sif.password"
jid="annie60@sc-dt-6.cisco.com"
jidpass="cisco123"
sed -i "s#$key7=.*#$key7=$jid#" $file4
sed -i "s#$key8=.*#$key8=$jidpass#" $file4


file5="VR5SIF/src/main/resources/META-INF/spring/CD/cd-configuration.properties"
key9="conductor.mgmt"
cd_mgr="sc-dt-6.cisco.com"
sed -i "s#$key9=.*#$key9=$cd_mgr#" $file5

echo "STEP5: Build SIF with Maven"
cd "VR5SIFPlatform"
/root/apache-maven-3.0.4/bin/mvn install -Dmaven.test.skip=true
