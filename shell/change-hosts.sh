#!/bin/bash
for server in "172.22.30.87" "172.22.30.240" "172.22.30.14" "172.22.28.19";
do ssh root@$server "sed -i 's/171.71.46.15/171.71.46.197/g' /etc/hosts"
done
