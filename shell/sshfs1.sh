#!/bin/bash
echo "Start sshfs"
#
#sudo /sbin/modprobe fuse
#Seems modprobe is NOT required with Unbuntu
sshfs hailwang@10.74.61.125:/home/hailwang/workspace/ ~/workspace/12.0.0.25-WS
sshfs hailwang@10.74.61.148:/home/hailwang/workspace/ ~/workspace/10.74.61.148-WS
sshfs hailwang@10.74.44.93:/auto/crdc_iptv/ ~/workspace/sha-iptv-ats
sshfs hailwang@shinchen-lnx:/auto/vcn-u1/hailwang/autotest/spcdn/base_herry/spcdn/automation ~/workspace/base
sshfs hailwang@shinchen-lnx:/auto/vcn-u1/hailwang/autotest/spcdn/automation ~/workspace/myws
sshfs hailwang@shinchen-lnx:/auto/iptv-sw/auto_vcn/regression/tests/iptv/auto_vcn/ ~/workspace/sanity_run

echo "Finish sshfs"
#then run meld to compare those two folders, ingoring .CC dir
fusermount -u ~/workspace/base
fusermount -u ~/workspace/myws
fusermount -u ~/workspace/sha-iptv-ats/
fusermount -u ~/workspace/sanity_run/
