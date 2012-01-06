#!/bin/bash
echo $HOME
echo $PATH
echo $#
echo $?
ls -l > result.out & 
echo "curent shell pid $$"
echo "last executed shell pid $!"
echo $!
echo $#
pid=$#

