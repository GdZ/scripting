#
#Version:1.01
#Modification Info:
#Use new SE lib, can upgrade all devices in parall
#07.06.12
global env
if {! [info exists env(AUTO_ROOT)]} {
set env(AUTO_ROOT) /auto/crdc_iptv/auto_vcn
puts "no env AUTO_ROOT\n"
}
if {! [info exists env(AUTO_TEST)]} {
set env(AUTO_TEST) $env(AUTO_ROOT)/tests
puts "no env AUTO_TEST\n"
}
if {! [info exists env(AUTO_LIBPATH)]} {
set env(AUTO_LIBPATH) $env(AUTO_ROOT)/lib
puts "no env AUTO_LIBPATH\n"
}
set AUTO_ROOT $env(AUTO_ROOT)
set AUTO_LIBPATH $env(AUTO_LIBPATH)
set AUTO_TEST $env(AUTO_TEST)
package require AtsAuto
source $AUTO_LIBPATH/se/se_lib.tcl
source $AUTO_TEST/upgrade/upgrade_ftpverify.tcl

set mandatory_args {
	-testbed_name ANY
}

set optional {-others ANY}

aetest::script_init -mandatory_args $mandatory_args \
                                    -optional_args $optional


aetest::testcase -tc_id se_upgrade {
    set casename "se_upgrade"
    set flag ""
    set version ""
    set information ""
    set alarm ""
    ats_results -name $casename
    ats_results -descr "upgrade image\n"
	
    aetest::section setup {
		source $AUTO_ROOT/testbed/CONFIG.$testbed_name
		set ftp_ip $tb_ftpserver(ip)
		set ftp_path $tb_ftpserver(path)
		set ftp_out_ip $tb_ftpserver(out_ip)
		
		if {[info exists env(PRIVATEIMAGE)] && $env(PRIVATEIMAGE) == "YES" } {
		#Use PrivateImage, overwirte ftp_ip,ftp_path,ftp_out_ip,
		#define myhostlist,ftp_upgrade_img
			if {[info exists env(HOSTSLIST)]} {
				set myhostlist [split $env(HOSTSLIST) ,]
				ats_log -info "Upgrade list is $myhostlist"
			} else {
				set myhostlist "ALL"
				ats_log -info "Using Default Hostlist : ALL Host"
			}
			if {[info exists env(IMAGEFTP_IP)]} {
				set ftp_ip $env(IMAGEFTP_IP)
				ats_log -info "FTP IP is $ftp_ip"
			} else {
				ats_log -error "invalid env:Please check IMAGEFTP_IP "
				aetest::goto end
			}
			if {[info exists env(IMAGEFTP_PATH)]} {
				#overwrite it
				set ftp_path $env(IMAGEFTP_PATH)
				ats_log -info "FTP Path is $ftp_path"
			} else {
				ats_log -error "invalid env Please check IMAGEFTP_PATH "
				aetest::goto end
			}
			if {[info exists env(IMAGEFTP_OUTIP)]} {
				#overwrite it
				set ftp_out_ip $env(IMAGEFTP_OUTIP)
				ats_log -info "FTP out ip:$ftp_out_ip"
			} else {
				ats_log -error "invalid env :Please check IMAGEFTP_OUTIP "
				aetest::goto end
			}
			if {[info exists env(IMAGEFTP_IMAGE)]} {
				set ftp_upgrade_img $env(IMAGEFTP_IMAGE)
				ats_log -info "ftp_upgrade_img=$ftp_upgrade_img"
			} else {
				ats_log -error "invalid env Please check IMAGEFTP_IMAGE "
				aetest::goto end
			}
			if {[imageftp_private_v $ftp_out_ip $ftp_path $ftp_upgrade_img] == 0} {
				ats_log -error "invalid image:Please check ftp $ftp_out_ip/$ftp_path"
				aetest::goto end
			} else {
				ats_log -info "ftp server is ok"
			}
		} else {
			atg_log -info "Using default configuration for upgrade!"
			set myhostlist "ALL"
			if { [imageftp_upgrade_v $ftp_out_ip $ftp_path] < 1} {
				ats_log -error "invalid image Please check ftp $ftp_out_ip/$ftp_path"
				aetest::goto end
			} else {
				ats_log -info "ftp server is ok"
			}
		}
		#constructure the specific devices list:
		foreach dev $tb_device_list {
			upvar #0 $dev my_tbdev
			set my_tbhostname $my_tbdev(hostname)
			set ix [lsearch -exact $myhostlist $my_tbhostname]
			if {$myhostlist == "ALL"} {
				set ix [llength $myhostlist]
			}
			if { $ix >=0 } {
				keylset selected_hostlist $my_tbhostname.console_ip "$my_tbdev(console_server)" \
			$my_tbhostname.console_port "$my_tbdev(telnet_console_port)"
			}
			puts [keylget selected_hostlist $my_tbhostname ]
		}
		puts [keylkeys selected_hostlist]
    }
	aetest::section upgrade_devices {
		#now get selected_hostlist.
		set my_upgradelist [keylkeys selected_hostlist]
		foreach dev_name $my_upgradelist {
			set tmp_ip [keylget selected_hostlist $dev_name.console_ip]
			set tmp_port [keylget selected_hostlist $dev_name.console_port]
			keylset selected_hostlist $dev_name.connectionid [se_console $tmp_ip $tmp_port]
		}
		se_upgrade_all $selected_hostlist $ftp_ip $ftp_path $ftp_upgrade_img
	}
    aetest::section verify_result {
		foreach dev $tb_device_list {
			upvar #0 $dev mydev
			if { $mydev(upgrade_flag) == "IGNO" } {
				puts "Bypass host: $mydev(hostname)"
				continue
			}
			set cd1 $mydev(connection_id)
			puts "$cd1 and hostname is $mydev(hostname)"
        	set version [se_cli $cd1 "show ver"]
        	regexp {(Version:.*)Compile Time} $version match information
        	ats_log -info $information
        	set alarm [se_cli $cd1 "show alarm"]
        	ats_log -info $alarm
			set showrun [se_cli $cd1 "show run"]
			ats_log -info $showrun
			set showdisk [se_cli $cd1 "show disk"]
			ats_log -info $showdisk
			se_close $cd1
        	if {$mydev(upgrade_flag) == "FAIL"} {ats_results -result fail} else {ats_results -result pass}    
		}
    }
}

