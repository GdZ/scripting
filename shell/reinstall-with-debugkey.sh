#!/bin/sh
echo "Step 1 : remove herrytest.apk"
rm herrytest.apk
echo "Step 2 : copy $1 to herrytest.apk"
cp $1 herrytest.apk
echo "Step 3 : remove META-INF in apk package"
zip -d herrytest.apk META-INF/\*
echo "Step 4 : sign app with debug key"
jarsigner -keystore ~/.android/debug.keystore -storepass android -keypass android herrytest.apk androiddebugkey
if [ "$2" = "htc" ] || [ "$2" = "both" ]; then
echo "Step 5 : uninstall app"
adb -s HT0CSHL18610 uninstall com.cisco.videoscape.android
echo "Step 6 : install app"
adb -s HT0CSHL18610 install herrytest.apk
fi

if [ "$2" = "nexus" ] || [ "$2" = "both" ]; then
echo "Step 7 : uninstall app"
adb -s 33348F8C48CC00EC uninstall com.cisco.videoscape.android
echo "Step 8 : install app"
adb -s 33348F8C48CC00EC install herrytest.apk
fi

echo "Done"
#cp videoscape1.2.59440.apk herrytest.zip
#unzip herrytest.zip -d herrytest
#rm -rf herrytest/META-INF
#rm herrytest.zip
#zip -r herrytest.apk herrytest
#rm -rf herrytest
