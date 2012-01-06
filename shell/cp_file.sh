#!/bin/bash
echo "Hello\n"
file_int=0
file_name="testfile"
while [ $file_int -le 100 ]
do 
echo "filename is $filecp_name"
echo "file_int is $file_int"
filecp_name=$file_name\_$file_int
#file_int=`expr $file_int +1`
file_int=$(($file_int+1))
cp $file_name $filecp_name
done
echo "END"

