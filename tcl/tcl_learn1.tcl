#!/home/hailwang/ats/ats4.4.0/bin/tclsh
puts "Test"
set info1 [info script]
puts "Scripts info $info1"
set info2 [file dirname $info1]
puts "Dir Name of scripts $info2"
set info3 [file join $info2]
puts "Dir name of $info3"
set  auto_path_info $auto_path
puts "auto path is $auto_path_info"
#puts "dir is $dir"
