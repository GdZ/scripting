#!/bin/bash
echo "show env var HOME PATH"
echo $HOME
echo $PATH
echo "show number of arguments"
echo $#
echo "exit status of last command excuted"
echo $?
ls -l > result.out & 
echo "pid of this shell "
echo "curent shell pid $$"
echo "last executed shell pid $!"
echo  "options of this shell"
echo $-
ls -la
echo  "Bash last argument of last command "
echo !$

echo "all the arguments, start from \$1"
echo $*

echo "all the arguments, start from \$1"
echo $@


echo "tr : translate"
echo $PATH |tr ':' '\n'

echo "tail one log file will be rotated"
echo "using --follow=name"
echo "fail --follow=name server.log"

echo "How to fine a string in all files recursively under current dir "

PWD = `pwd`
for file in `find $PWD -name filename`
do grep -l "patterns $file
done

echo "or using rgrep"


echo "reverse one text file"
cat demo.txt
tac demo.txt
echo "refer this: http://stackoverflow.com/questions/742466/how-can-i-reverse-the-order-of-lines-in-a-file "

echo "when tac is not working, using sed"
#G: append hold space to pattern space
#h: copy pattern space to hold space
sed '1!G;p;h;$!d' demo.txt

