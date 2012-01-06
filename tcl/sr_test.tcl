#!/~/ats/ats4.4.0/bin/tclsh
package require tdom
package require ip
#By Herry Wang: hailiangwang@gmail.com
#Function:
#Parse Coverage Zone file
#Find out the most match network, as well as the matric, SE according with Client's ip
#Comments:
#The most complicated part is how to get the longext prefix network
#In fact, tcllib::ip provide such procedure. However, ats tree does not use the latest tclib package
#So, a few additioanl procedure have been ported into this procedure


#input:
#XML coverage zone file
#Client IP address, format 1.2.3.4/24
#output:
#cresponding network, matric, SE


proc lassign {values args} {
	uplevel 1 [list foreach $args $values break]
	lrange $values [llength $args] end
}
proc iptoHex {ip} {
	binary scan [ip::Normalize4 $ip] H8 out
	return "0x$out"
}
proc ipmaskToInt {mask} {
	if {[string is integer -strict $mask]} {
		set maskInt [expr {(0xFFFFFFFF << (32 - $mask))}]
	} else {
		binary scan [Normalize4 $mask] I maskInt
	}
	set maskInt [expr {$maskInt & 0xFFFFFFFF}]
	return [format %u $maskInt]
}
proc prefixToNative {prefix} {
	set plist {}
	foreach p $prefix {
		set newPrefix [iptoHex [ip::prefix $p]]
		if {[string equal [set mask [ip::mask $p]] ""]} {
			set newMask 0xffffffff
		} else {
			set newMask [format "0x%08x" [ipmaskToInt $mask]]
		}
		lappend plist [list $newPrefix $newMask]
	}
	if {[llength $plist]==1} {return [lindex $plist 0]}
	return $plist
}
proc ipisOverlap {ip args} {
	lassign [SplitIp $ip] ip1 mask1
	set ip1int [toInteger $ip1]
	set mask1int [maskToInt $mask1]

	set overLap 0
	foreach prefix $args {
		lassign [SplitIp $prefix] ip2 mask2
		set ip2int [toInteger $ip2]
		set mask2int [maskToInt $mask2]
		set mask1mask2 [expr {$mask1int & $mask2int}]
		if {[expr {$ip1int & $mask1mask2}] ==  [expr {$ip2int & $mask1mask2}]} {
			set overLap 1
			break
		}
	}
	return $overLap
}

proc ipmaskToLength {mask args} {
	set ipv4 1
	while {[llength $args]} {
		switch -- [lindex $args 0] {
			-ipv4 {set args [lrange $args 1 end]}
			default {
				return -code error [msgcat::mc "option %s not supported" [lindex $args 0]]
			}
		}
	}
#pick the fastest method for either format
	if {[string is integer -strict $mask]} {
		binary scan [binary format I [expr {$mask}]] B32 maskB
		if {[regexp -all {^1+} $maskB ones]} {
			return [string length $ones]
		} else {
			return 0
		}
	} else {
		regexp {\/(.+)} $mask dumb mask
		set prefix 0
		foreach ipByte [split $mask {.}] {
			switch $ipByte {
				255 {incr prefix 8; continue}
				254 {incr prefix 7}
				252 {incr prefix 6}
				248 {incr prefix 5}
				240 {incr prefix 4}
				224 {incr prefix 3}
				192 {incr prefix 2}
				128 {incr prefix 1}
				0   {}
				default { 
					return -code error [msgcat::mc "not an ip mask: %s" $mask]
				}
			}
			break
		}
		return $prefix
	}
}

proc ipisOverlapNative {args} {
	set all 0
	set inline 0
	set notOverlap 0
	set ipv4 1
	foreach sw [lrange $args 0 end-3] {
		switch -exact -- $sw {
			-all {
				set all 1
				set allList [list]
			}
			-inline {set inline 1}
				-ipv4 {}
			}
		}
	set args [lassign [lrange $args end-2 end] ip1int mask1int prefixList]
		if {$inline} { 
			set overLap [list]
		} else {
			set overLap 0
		}
	set count 0
	foreach prefix $prefixList {
		incr count
			lassign $prefix ip2int mask2int
			set mask1mask2 [expr {$mask1int & $mask2int}]
			if {[expr {$ip1int & $mask1mask2}] ==  [expr {$ip2int & $mask1mask2}]} {
				if {$inline} {
					set overLap [list $prefix]
				} else {
					set overLap $count
				}
				if {$all} {
					if {$inline} {
						lappend allList $prefix
					} else {
						lappend allList $count
					}
				} else {
					break
				}
			}
		}
	if {$all} {return $allList}
	return $overLap
}


proc ipnativeToPrefix {nativeList args} {
	set pList 1
	set ipv4 1
	while {[llength $args]} {
		switch -- [lindex $args 0] {
			-ipv4 {set args [lrange $args 1 end]}
			default {
				return -code error [msgcat::mc "option %s not supported" [lindex $args 0]]
			}
		}
	}

# if a single native element is passed eg {0x01010100 0xffffff00}
# instead of {{0x01010100 0xffffff00} {0x01010100 0xffffff00}...}
# then return a (non-list) single entry
	if {[llength [lindex $nativeList 0]]==1} {set pList 0; set nativeList [list $nativeList]}
	foreach native $nativeList {
		lassign $native ip mask
		if {[string equal $mask ""]} {set mask 32}
		set pString ""
		append pString [ip::ToString [binary format I [expr {$ip}]]]
		append pString  "/"
		append pString [ipmaskToLength $mask]
		lappend rList $pString
	}
# a multi (listified) entry was given
# return the listified entry
	if {$pList} { return $rList }
	return $pString
}

proc longestPrefixMatch { ipaddr prefixList args} {
	set ipv4 1
		while {[llength $args]} {
			switch -- [lindex $args 0] {
				-ipv4 {set args [lrange $args 1 end]}
				default {
					return -code error [msgcat::mc "option %s not supported" [lindex $args 0]]
				}
			}
		}
#find out format of prefixes
	set dotConv 0
		if {[llength [lindex $prefixList 0]]==1} {
#format is dotted form convert all prefixes to native form
			set prefixList [prefixToNative $prefixList]
				set dotConv 1
		}
#sort so that most specific prefix is in the front
	if {[llength [lindex [lindex $prefixList 0] 1]]} {
		set prefixList [lsort -decreasing -integer -index 1 $prefixList]
	} else {
		set prefixList [list $prefixList]
	}
	if {![string is integer -strict $ipaddr]} {
		set ipaddr [prefixToNative $ipaddr]
	}
	set best [ipisOverlapNative -inline \
		[lindex $ipaddr 0] [lindex $ipaddr 1] $prefixList]
		if {$dotConv && [llength $best]} {
			return [ipnativeToPrefix $best]
		}
	return $best
}

proc get_se_by_czfile {cfg_file client_ip} { 

	if [catch {
		set fd [open $cfg_file r]
	} error ] {
		puts "File open error:$error"
			return -1
	}
	set doc [dom parse -channel $fd]
		set root [$doc documentElement]
		set Zones [$root selectNodes /CDNNetwork/coverageZone] 
		set czfile_parse_list {}
	set net_list {}

	foreach zone $Zones {
		set net [$zone selectNodes network/text()]
			puts [$net data]
			set metric [$zone selectNodes metric/text()]
			puts [$metric data]
			set sename [$zone selectNodes SE/text()]
			puts [$sename data]
			set net_se_list [list [$net data] [$metric data] [$sename data]]
			lappend net_list [$net data]
			lappend czfile_parse_list $net_se_list
	}
	close $fd

	#now we have the list czfile_parse_list
	#next to get the exact
	puts $net_list
	puts $client_ip
	#puts $czfile_parse_list
	set matched_net [longestPrefixMatch $client_ip $net_list]
	puts "Matched network $matched_net"
	#probbally we meet multiple entries in list, with diffrent metric
	# get the least metric

	set rec_matric 1000
	set rec_se ""
	foreach el_net_list $czfile_parse_list {
		if {[lindex $el_net_list 0] == $matched_net } { 
			if {[lindex $el_net_list 1] < $rec_matric } {
				set rec_matric [lindex $el_net_list 1]
				set rec_se [lindex $el_net_list 2]
			}
		}
	}

	puts "Returned: Metric: $rec_matric SE-IP: $rec_se Network: $matched_net"	


}

proc get_se_by_loc {cfg_file client_loc} { 

	if [catch {
		set fd [open $cfg_file r]
	} error ] {
		puts "File open error:$error"
			return -1
	}
	set doc [dom parse -channel $fd]
		set root [$doc documentElement]
		set Zones [$root selectNodes /CDNNetwork/coverageZone] 
		set czfile_parse_list {}
	set loc_list {}

	foreach zone $Zones {
		set loc_lat [$zone selectNodes location/latitude/text()]
		puts [$loc_lat data]
		set loc_long [$zone selectNodes location/longitude/text()]
		puts [$loc_long data]
		set metric [$zone selectNodes metric/text()]
		puts [$metric data]
		set sename [$zone selectNodes SE/text()]
		puts [$sename data]
		set loc_info [list [$loc_lat data] [$loc_long data] ]
		set loc_se_list [list $loc_info [$metric data] [$sename data]]
		lappend loc_list $loc_info
		lappend czfile_parse_list $loc_se_list
	}
	close $fd

	#now we have the list czfile_parse_list
	#next to get the exact
	puts $loc_list
	puts $client_loc
	#puts $czfile_parse_list
	set matched_loc [closestLocMatch $client_loc $loc_list]
	puts "DEBUG Matched Location $matched_loc"
	#probbally we meet multiple entries in list, with diffrent metric
	# get the least metric

	set rec_matric 1000
	set rec_se ""
	foreach el_loc_list $czfile_parse_list {
		if {[lindex $el_loc_list 0] == $matched_loc } { 
			if {[lindex $el_loc_list 1] < $rec_matric } {
				set rec_matric [lindex $el_loc_list 1]
				set rec_se [lindex $el_loc_list 2]
			}
		}
	}

	puts "Returned: Metric: $rec_matric SE-IP: $rec_se Location: $matched_loc"	


}
proc closestLocMatch {client_loc loc_list} {
	#puts $client_loc
	#puts $loc_list
	set min_dist 1000000
	set min_index 0
	set dist_list {}
	foreach el_loc $loc_list {
		set x_0 [lindex $el_loc 0]
		set y_0 [lindex $el_loc 1]
		set x_1 [lindex $client_loc 0]
		set y_1 [lindex $client_loc 1]
		set distance [expr { sqrt(pow(($x_0 - $x_1),2)+pow(($y_0-$y_1),2))}]
		lappend dist_list $distance
		#if {[lindex $el_loc 0] == [lindex $client_loc 0] && [lindex $el_loc 1] == [lindex $client_loc 1]} {
		#	return $client_loc
		#}
	}
	set leng_of_list [llength $dist_list]
	for {set i 0} {$i < $leng_of_list } {incr i} {
		if {[lindex $dist_list $i] < $min_dist} {
			set min_dist [lindex $dist_list $i]
			set min_index $i
		}
	}
	puts "Matched SE Loc: [lindex $loc_list $min_index]"
	return [lindex $loc_list $min_index]
}
set cfg_file "cz_sample.xml"
set geo_cz_file "tb_vcnbu_sj4_1305525818.xml"
set client_ip "172.22.12.102/24"
set client_loc [list "30" "28"]
#get_se_by_czfile $cfg_file $client_ip
get_se_by_loc $geo_cz_file $client_loc

