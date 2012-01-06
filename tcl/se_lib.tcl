##############################################
# function :
# se_terminal
# return :
# telnet_id -- success
# -1 -- fail
##############################################

proc se_terminal {ip_addr number} {

 set spid [spawn telnet $ip_addr ]
 set telnet_id $spawn_id
 set timeout 20
# after 100
 send "\r"
 send "\r"

 expect {
 -re "Username: " {
    send "iptv\r"
        expect {
            sleep 1
            "Password" {
            send "iptv\r"
            send "\r"
            sleep 1
            send "\r"
                expect {
                -re ".*Selection: " {
                send "clr$number\r"
                    expect {
                    -re "confirm" {
                       send "\r"
                       send "\r"
                      }
                    timeout {return -1}
                    }
                sleep 2
                send "$number\r"
                    expect {
                    -re "Password OK" {
                        puts "now password is OK."
                        send "\r"
                        send "\r"
                        set timeout 5
                        expect {
                          -re ".*Username: " {
                            sleep 1
                            send "admin\r"
                            expect {
                              -re ".*Password: " {
                                sleep 1
                                send "default\r"
                                
                              }
                              timeout {puts "username is not OK" ;return -1} 
                            }
                          }
                          -re ".*login: $" {
                            puts "now need login"
                            send "admin\r"
                            expect {
                               -re ".*Password: $" {
                               send "default\r"
                               send "\r"
                               }
                               timeout {puts "username is not OK" ;return -1}
                            }           
                          }
                        }
                      }
                    timeout {puts "Password is not OK " ;return -1}
                            }
                }
                timeout {
                #puts "\n Here"
                puts "Can't connect $ip_addr:. Invalid User/Password"
                return -1
                }
                }
                }
            }
        }
      timeout {return -1}
    }
    
    send "\r"
    puts "now out of the expect."
    se_prompt $telnet_id #
    send "\r"
            
    puts "return telnet id."
    return $telnet_id

}

proc se_console {ip port {user admin} {passwd default}} {
    if [catch {
       	set spid [spawn telnet $ip $port]
    } err] {
        puts "Try to connect $ip $port ERROR: $err"
        return -1
    	}
#For Solaris--Herry
sleep 2
	send "\r"
    set timeout 20
    #expect {
    #    -re ".*Password OK.*" {puts "telnet OK"}
    #    timeout {puts "telnet timeout" ; return -1}
    #    }
    #set timeout 10
    set telnet_id $spawn_id
    send "\r"
    send "\r"
    expect {
        -re ".*Username: " {
        puts "need username"
        sleep 1
        send $user
        send "\r"
        expect {
            -re ".*Password: " {
            sleep 1
            send $passwd
            send "\r"
            send "\r"
            sleep 1
            se_prompt $telnet_id #
            }
        timeout {puts "username is not OK" ;return -1}
        }
        }
                          
        -re ".*login: $" {
        puts "now need login"
        send $user
        send "\r"
        expect {
            -re ".*Password: $" {
            send $passwd
            send "\r"
            send "\r"
            sleep 1
            se_prompt $telnet_id #
            }
            timeout {puts "username is not OK" ;return -1}
        }           
        }
        
        -re {.*config.#$} {
          puts "now is config mode"
          send "exit\r"
          sleep 1
          se_prompt $telnet_id #
        }
        
        -re ".*#$" {
          set timeout 3
          send "\r"
          puts "succeed in #"
        }
        
        -re "--More--" {
          puts "now is  --More--"
          send " "
          se_prompt $telnet_id #
        }
        
        -re ".*debugshell# $" {
          puts "now is debugshell"
          send "exit\r"
          sleep 1
          send "\r"
          se_prompt $telnet_id #
          }
        
        timeout {puts "telnet is not OK" ;return -1}
    }
    return $telnet_id
}



# ------------------------------------------------------------------------------
# Proc: se_connect
#
# Connect to a SE. It can connect to either the com port or the telnet port of 
# the SE. The function handles all possible situations so that at the end it
# will provide an administrative prompt (#) 
#
# Params:
#   ip_addr = IP address to connect to (com server or the SE itself)  
#   port    = The port to connect to; default=23
#   user    = Username to use in case it is required; default "admin" 
#   passwd  = Password to use in case it is required; default "default"
#  
# Returns: 
#   Connection descriptor
#
#===============================================

proc se_connect { ip_addr { port 23 } {user admin} {passwd default} {expect_timeout 10} {max_tries 8} } {

#  set max_tries 8
  set tries     $max_tries
  # Try connecting $tries times
  while { $tries > 0 } {

    if { $port == 23 } {
      if [catch {
        set spid [spawn telnet $ip_addr]
        set telnet_id $spawn_id
      } err] {
        puts "Try to connect $tries ERROR: $err"
        incr tries -1
        continue
      }
    } else {
		if { $port < 2048 } {
			if [catch {
       			set spid [spawn telnet $ip_addr $port]
				set telnet_id $spawn_id
			} err] {
        		puts "Try to connect $tries ERROR: $err"
        		incr tries -1
        		continue
      		}
    	} else {
			 set cd [openSession $ip_addr $port]
                   #puts "Output is $cd"
                   return $cd
		}
	}

    if [catch { set telnet_id $spawn_id} err ] {

 puts "Can't connect to telnet port $ip_addr:$port"
    }
    set timeout $expect_timeout



    # CE can be in the middle of a command output
     after 100

	set int_ext_ip [split $ip_addr "."]
	set int_ext_ip [lindex $int_ext_ip 0]
	
	if { $int_ext_ip != 10} {	
	sleep 2  
	}

    send "\r"
    send "\r"
    send "\r"
    send "\r"
    puts "DEBUG> Waiting for CE to respond"
    send "\r"
    set error 1
    expect {
      -re ".*login: " {
        send "$user\r"
	sleep 2
        expect {
          -re "\[Pp]assword" {
            send "$passwd\r"
            send "\r"
            after 10
            send "\r"
            expect {
              -re ".*#" {
                #send "en\r"
                puts "Connected $ip_addr:$port. Have #."
                set error 0
              }
              -re ".*>" {
                puts "Connected $ip_addr:$port. Have >."
                set error 0
              }
              timeout {
                #puts "\n Here"
                puts "Can't connect $ip_addr:$port. Invalid User/Password"
              }
            }
          }
          timeout  {
            puts "Can't connect $ip_addr:$port. Password Prompt Timeout"
          }
        }
      }
      -re "Username:" {
        send "$user\r"
        expect {
          -re "\[Pp]assword" {
            send "$passwd\r"
            send "\r"
            after 10
            send "\r"
            expect {
              -re ".*#" {
                puts "Connected $ip_addr:$port. Have #."
                set error 0
              }
              timeout {
				puts "\n Here1"
                puts "Can't connect $ip_addr:$port. Wrong user/password"
              }
              -re ".*>" {
                #send "en\r"
                puts "Connected $ip_addr:$port. Have >."
                set error 0
              }
              timeout {
                puts "\n Here1"
                puts "Can't connect $ip_addr:$port. Wrong user/password"
              }
            }
          }
          timeout  {
            puts "Can't connect $ip_addr:$port. Timeout"
          }
        }
        puts "Connected $ip_addr:$port. Have #."
        #set error 0
      }
      -re ".*config.*#$" {
        send "\r"
		
		puts "Connected $ip_addr:$port. Have #."
        set error 0
      }
      -re {[a-zA-Z0-9\-]*#$} {
        puts "Connected $ip_addr:$port. Have #."
        set error 0
      }
	  -re {debugshell} {
		send "exit\r"
	  }	
      -re ".*\% $" {
        # puts "Connected $ip_addr:$port. Have %."
        set error 0
        se_prompt $telnet_id "#"

  	  }
      -re ".*\>$" {
        # puts "Connected $ip_addr:$port. Have >."
        set error 0
        #se_prompt $telnet_id "#"
      }
      -re "--More--" {
        # puts "Connected $ip_addr:$port. Have --More--."
        set error 0
        se_prompt $telnet_id "#"
      }
      timeout  {
                puts "\n Here2"
        puts "Can't connect $ip_addr:$port. Timeout"
      }
    }

    if { $error } {
      # Wait for the connection to get closed, if it is still pending
      after [expr 200 * ( $max_tries - $tries)]
      incr tries -1
	
	if { $tries == 4 } {
	set passwd "diamond"
	} 
      #catch { kill -TERM $spid }
      catch { ce_close $spawn_id }
    } else {
      return $telnet_id
    }

}; # while

  puts "ERROR> An error occured while connecting to $ip_addr:$port"
  return -1
}; # proc se_connect

# ------------------------------------------------------------------------------
# Proc: se_getConfigValue
#
# For CLI commands that have outputs like:
#   <item1> <value1>
#   <item2> <value2>
# retrieve value (the string from the end of <item> to the end of line
#
# Params:
#   cmd_output  - the output of the command 
#   item        - the item whose value I want to get  
# Returns:      - item value (string)
#   
proc se_getConfigValue { cmd_output item } {

  set eol [format "%c" 0x0a]
  if { [regexp "$item\[ =:\](\[^$eol\]*)$eol" $cmd_output all v rest] } {
    # at_trace "ConfigValue: $v"
    return $v   
  }
  # at_trace "ConfigValue: MISSMATCH $cmd_output / $item"
  return ""
  
}; # proc se_getConfigValue



######################################################
# function :
# se_cms_register
# return :
# 0 -- success
# 1 -- fail
# 2 -- cms is already enable
######################################################

proc se_cms_register {cd cdm_ip} {
  set spawn_id $cd
  send "config\r"
  send "\r"
  send "\r"
  
  expect {
  -re ".config.#" {
    puts "come into config mode."
    send "cdsm ip $cdm_ip\r"
    expect {
      -re {This command is not available on primary CDSM} {
        puts "This is a primary CDSM"
        }
      }
    set timeout 30
    send "cms enable\r"
      expect {
       -re "Proceed\?.*" {
          sleep 2
          puts "go on proceeding"
          send "yes\r"
            expect {
              -re "management services enabled" {
                send "exit\r"
                send "\r"
                puts "SE management services is enabled."
                }
              timeout {puts "wait register time out"
                       return 1
                      }
            }
          }
        -re "management services enabled" {
            send "exit\r"
            send "\r"
            puts "SR management services is enabled."       
        }
        -re "management services are already enabled." {
           send "exit\r"
           send "\r"
           puts "cms is already enabled."
           return 2
          }
        }
  }
  }
  send "show cms info\r"
  expect {
    -re "Service cms_.* is running" {
      puts "register cdsm is successful"
      return 0
      }
    }  
  return 1  
  }
  
#########################################
# function :
# se_cms_deregister
# return :
# 0 -- success
# 1 -- fail
#########################################
  
  
proc se_cms_deregister {cd} {
    
    set spawn_id  $cd
    set timeout 10
    
    send "cms deregister force \r"
    sleep 5
    expect {
        -re {.*Proceed\? .no.} {
                send "yes\r"
                sleep 50
                }
#if the device is CDSM, we should response this question.
        -re {.*Do you really want to continue .no.\?} {
                send "yes\r"
                sleep 50
            }
        -re {.*deregistration is not needed.*} {
              puts "deregister is OK."  
              return 0
        }
    }
    
    send "show cms info\r"
    expect {
    -re "This node has not yet been configured" {
         puts "deregister is OK."
         return 0
         }
    timeout {puts "deregister is timeout " ;return 1}
           }
}

############################################################
# function :
# se_upgrade
# return :
# 0 -- success
# 1 -- fail
############################################################
proc se_upgrade {cd dir filename ftp_addr {user_name ftp} {passwd vcnbu}} {
        set spawn_id $cd
        set copyflag 0
        send "copy ftp install $ftp_addr $dir $filename\r"
        expect {
            -re "Enter username for remote ftp server: " {
                send "$user_name\r"
                    expect {
                        -re "Enter password for remote ftp server: " {
                            send "$passwd\r"
                            set timeout 600
                                expect {
                                    -re "The new software will run after you reload." {
                                            puts "copy ftp intall is OK ,you need reload it."
                                            set copyflag 1
                                            }
                                    timeout {puts "timeout"}
                                       
                                       }
                            }
                           }
                }
               }
    if {$copyflag} {
        send "\r"
        send "\r"
        send "reload\r"
        expect {
        -re ".*Proceed with reload\?.*" {
            sleep 1
            send "\r"
        }
        -re "System configuration has been modified. Save\?.*yes.*:" {
            sleep 1
            send "\r"
            expect {
            -re ".*Proceed with reload\?.*" {
                sleep 1
                send "\r"
                }
                   }            
            }
               }
        #sleep 290
set timeout 600
    expect {
            -re ".*Cisco Service Engine Console.*" {
                puts "reload is also Ok."
                send "\r"
                send "\r"
                expect {
                -re ".*Username: $" {
                    puts "send username."
                    send "admin\r"
                    expect {
                        -re ".*Password: " {
                            puts "send passwd"
                            send "default\r"
                            send "\r"
                            send "\r"
                            expect {
                                -re ".*#" {puts "now ,return to exec mode." ;return 0}
                                }
                            }
                        }
                    }
                }
              }
              -re ".*Cisco Service Router Console.*" {
                puts "reload is also Ok."
                send "\r"
                send "\r"
                expect {
                -re ".*Username: " {
                    puts "send username."
                    send "admin\r"
                    expect {
                        -re ".*Password: " {
                            puts "send passwd"
                            send "default\r"
                            send "\r"
                            send "\r"
                            expect {
                                -re ".*#" {puts "now ,return to exec mode." ;return 0}
                                }
                            }
                        }
                    }
                }
              }
              -re ".*Cisco Content Delivery System Manager Console.*" {
                puts "reload is also Ok."
                send "\r"
                send "\r"
                expect {
                 -re ".*Username: " {
                    puts "send username."
                    send "admin\r"
                    expect {
                        -re ".*Password: " {
                            puts "send passwd"
                            send "default\r"
                            send "\r"
                            send "\r"
                            expect {
                                -re ".*#" {puts "now ,return to exec mode." ;return 0}
                            }
                          }
                    }
                  }
                }
            }
    timeout { puts "reload is time out." ; return 1}
    }
}
    
    
    puts "copy ftp install failed."
    return 1
}

#####################################################
# function :
# se_reload
# return :
# 0 -- success
# 1 -- fail
#####################################################
proc se_reload {cd} {
    set spawn_id $cd
    send "\r"
    send "\r"
    send "reload\r"
    expect {
        -re ".*Proceed with reload\?.*" {
            sleep 1
            send "\r"
        }
        -re "System configuration has been modified. Save\?.*yes.*:" {
            sleep 1
            send "\r"
            expect {
             -re ".*Proceed with reload\?.*" {
                sleep 1
                send "\r"
              }
            }            
        }
    }
    sleep 290
    expect {
            -re ".*Cisco Service Router Console.*" {
                puts "reload is also Ok."
                send "\r"
                send "\r"
                expect {
                -re ".*Username: " {
                    puts "send username."
                    send "admin\r"
                    expect {
                        -re ".*Password: " {
                            puts "send passwd"
                            send "default\r"
                            send "\r"
                            send "\r"
                            expect {
                                -re ".*#" {puts "now ,return to exec mode." ;return 0}
                                }
                            }
                        }
                    }
                }
              }
            -re ".*Cisco Content Delivery System Manager Console.*" {
                puts "reload is also Ok."
                send "\r"
                send "\r"
                expect {
                 -re ".*Username: " {
                    puts "send username."
                    send "admin\r"
                    expect {
                        -re ".*Password: " {
                            puts "send passwd"
                            send "default\r"
                            send "\r"
                            send "\r"
                            expect {
                                -re ".*#" {puts "now ,return to exec mode." ;return 0}
                            }
                          }
                    }
                  }
                }
            }
            -re ".*Cisco Service Engine Console.*" {
                puts "reload is also Ok."
                send "\r"
                send "\r"
                expect {
                 -re ".*Username: " {
                    puts "send username."
                    send "admin\r"
                    expect {
                        -re ".*Password: " {
                            puts "send passwd"
                            send "default\r"
                            send "\r"
                            send "\r"
                            expect {
                                -re ".*#" {puts "now ,return to exec mode." ;return 0}
                            }
                          }
                    }
                  }
                }
              }
    }
        return 1
  }



##########################################
# function : se_mode
# mode :
# 1 -- cdsm
# 2 -- sr
# 3 -- se
# return :
# 0 -- success
# 1 -- fail
##########################################
proc se_mode {cd mode} {
    
    switch -exact -- $mode {
        1 {
            puts "device mode : cdsm"
            set out [se_cli $cd "show device-mode current"]
            puts "show device mode :$out"
            if {[regexp -nocase {content-delivery-system-manager} $out]} {
            puts "device is already a cdsm"    
            return 0
                }
            if {[se_cms_deregister $cd]} {
                return 1
                }
            puts "QiZhang : come into config mode"
                set spawn_id $cd
                send "config\r"
                sleep 1
             set out [se_cli $cd "device mode content-delivery-system-manager"]
             if {[regexp -nocase {after a reload} $out]} {
                puts "begin to reload"
                send "exit\r"
                sleep 1
                if {![se_reload $cd]} {
                    puts "reload finished."
                    set verify [se_cli $cd "show device-mode current"]
                    puts "show device mode :$verify"
                    if {[regexp -nocase {content-delivery-system-manager} $verify]} {
                       puts "change to cdsm successfully"
                       return 0
                     }              
                    return 1}
                }
        }
        2 {
            puts "device mode :sr"
            set out [se_cli $cd "show device-mode current"]
            puts "show device mode :$out"
            if {[regexp -nocase {service-router} $out]} {
                puts "device is already a sr"
                return 0
                }
            if {[se_cms_deregister $cd]} {
                return 1
                }
             set spawn_id $cd
                send "config\r"
                sleep 1
             set out [se_cli $cd "device mode service-router"]
             if {[regexp -nocase {after a reload} $out]} {
                puts "begin to reload"
                send "exit\r"
                sleep 1
                if {![se_reload $cd]} {
                    puts "reload finished."
                    set verify [se_cli $cd "show device-mode current"]
                    puts "show device mode :$verify"
                    if {[regexp -nocase {service-router} $verify]} {
                       puts "change to sr successfully"
                       return 0
                     }              
                    return 1}
                }           
        }
        3 {
            puts "device mode :se"
            set out [se_cli $cd "show device-mode current"]
            puts "show device mode :$out"
            if {[regexp -nocase {service-engine} $out]} {
                puts "device is already a se"
                return 0
                }
            if {[se_cms_deregister $cd]} {
                return 1
                }
                set spawn_id $cd
                send "config\r"
                sleep 1
             set out [se_cli $cd "device mode service-engine"]
             if {[regexp -nocase {after a reload} $out]} {
                puts "begin to reload"
                send "exit\r"
                sleep 1
                if {![se_reload $cd]} {
                    puts "reload finished."
                    set verify [se_cli $cd "show device-mode current"]
                    puts "show device mode :$verify"
                    if {[regexp -nocase {service-engine} $verify]} {
                       puts "change to se successfully"
                       return 0
                     }              
                    return 1}
                }    
        }
    }
    puts "mode config fail"
    return 1
}

proc checkSE {cd dir filename} {
    Enter_DebugShell $cd
    se_cli $cd "cd $dir"
    set content [se_cli $cd "cat $filename"]
#    set result [eliminate $content]
    set match ""
    set sub1 ""
    set flag [regexp -nocase {lookup_task: writing se '(.*)' shr_reply_flags} $result match sub1]
    puts "flag : $flag"
    if {!$flag} {
        return 1    
    }
    puts "se hostname : $sub1"
    return $sub1   
}


#################################################
#
#function : se_prompt
#prompt :
#        "#" exec mode
#        "config" config mode
#        "zzdebugshell" debugshell mode
#return :
# 0 -- success
# 1 -- fail
#################################################
proc se_prompt { cd prompt} {

  set spawn_id $cd
  set timeout 10 
  #puts "in se_prompt"
  send "\r"

  switch $prompt {

    "#" {

      expect {
        -re {.*config.#$} {
          #puts "now is config mode"
          send "exit\r"
          sleep 1
          return [se_prompt $cd $prompt]
        }
        -re ".*#$" {
          set timeout 3
          send "\r"
          #puts "succeed in #"
          return 0
        }
        -re "--More--" {
          #puts "now is  --More--"
          send " "
          return [se_prompt $cd $prompt]
        }
        -re ".*Username: $" {
           #puts "now need user:passwd"
           send "admin\r"
           expect {
            -re ".*Password: $" {
              send "default\r"
              send "\r"
              }
             }
           return [se_prompt $cd $prompt]         
          }
        -re ".*login: $" {
           #puts "now need login"
           send "admin\r"
           expect {
             -re ".*Password: $" {
              send "default\r"
              send "\r"
              }
            }           
           return [se_prompt $cd $prompt]          
          }
        -re ".*debugshell# $" {
          #puts "now is debugshell"
          send "exit\r"
          sleep 1
          send "\r"
          return [se_prompt $cd $prompt]
          }
        timeout {puts "can't come into #,timeout";return 1}
      }
    }
    "config" {
      expect {
        -re {.config.#$} {
          #puts "succeed in config"
          return 0
          }
        default {
          if { [se_prompt $cd "#"] == 0 } {
            send "config\r"
            sleep 1
            return [se_prompt $cd "config"]
          } else {
            return 1
          }
        }
      }

    }

    "zzdebugshell" {
      expect {
        -re ".*debugshell# $" {
          #puts "succeed in zzdebugshell"
          return 0
          }
        default {
          if { [se_prompt $cd "#"] == 0 } {
            #puts "se_prompt equal 0"
            send "zzdebugshell\r"
            sleep 1
            send "homer\r"
            return [se_prompt $cd "zzdebugshell"]
          } else {
            return 1
          }
        }
      }
    }

    default {
      # puts "No such prompt"
      return 1
    }
  }; # switch
}; # proc se_prompt


proc Enter_DebugShell {cd} {
    se_cli  $cd "zzdebugshell"
    se_cli  $cd "homer"
}

proc eliminate_nonascii { str } {

  set res_str ""
  set len  [ string length $str ]
  for { set i 0 } { $i < $len } { incr i } {
    binary scan [string index $str $i] c bin_chr
    if { ( $bin_chr < 0x09 ) || ( $bin_chr > 0x80 ) } {
      continue
    }
    append res_str [ format "%c" $bin_chr ]
  }
  return $res_str

}; # proc eliminate_nonascii

proc se_captureraw {cd cmd {tout 20} } {
	set res           ""
	set end_of_output 0
	set spawn_id      $cd
	set timeout       $tout
	send "$cmd\r"
	set cmd1 [lrange $cmd 0 2]
	expect {
		"$cmd1" {
			set cmd_str $expect_out(buffer)
		}
	}
	while { $end_of_output == 0 } {
		expect {
			-re "debugshell#" {
				append res $expect_out(buffer)
				set end_of_output 1
			}
			-re ".*--More--.*" {
					send " "
					append res $expect_out(buffer)
			}
			timeout	{
				puts "****Timeout in se_captureraw***"
				set end_of_output 1
			}
		}
	}
	return $res
}; #proc se_captureraw

################################################################################
# Proc: se_cli
#
# Subbmits a CLI command and returns the answer. Requires a connection to 
# be open with se_connect.
#
# Implementation details: 
#  - Press <SPACE> if the answer prompts -More- and returns
#    the whole answer. 
#  - If the command ends with "?" then don't press <enter> like
#    after all other commands and erase the command which is automatically
#    written after the help is printed 
#
# Params:
#   cd       - conncetion descriptor
#   cmd      - command string
#   tout     - timeout; default is 40 sec
#
# Returns: comand output
#################################################################################

proc se_cli { cd cmd {tout 10} {user root} {passwd Cisco-iptv} } {
	#puts "for cli_exec : cmd : $cmd"

  set res           ""
  set end_of_output 0
  set spawn_id      $cd
  set timeout       $tout
  set nl            1

  # Prepare for the commands with "?"
  set cmd [string trim $cmd " "]
  if { ( [string last ? $cmd] == [expr [string length $cmd] - 1])
    && ( [string length $cmd] > 0) } {
    # puts "Have a ? cmd"
    set nl 0
    if { [string length $cmd] > 2 } {
      set residual_cmd [string range $cmd 0 [expr [string length $cmd] - 2]]
    } else {
      set residual_cmd ""
    }
  } else {
    set residual_cmd ""
  }
 send "$cmd"
  if { $nl } { send "\r" }
  #puts "\n--- Put $cmd ---"

  # Expect telnet to echo back the command that we just sent
  set cmd_str "<$cmd>"

##changed to look for partial command output on 24/06/2002 to fix the cmd wrap up timing issue by pselvara

 set cmd1 [lrange $cmd 0 2]

#added by sruthrap, logging into debugshell will be faster. Previously if these commands are executed , the only way to come out of this procedure is through timeout. Now it is handled.
	if { $cmd == "homer" } {
		set timeout 1
		set end_of_output 1
	}

  expect {
    "$cmd1" {
      # puts "\n--- GOT command string back. Start looking for command output"
      set cmd_str $expect_out(buffer)
    }
	}

	if { $cmd == "zzdebugshell" } {
			set end_of_output 1
	}

	if { $cmd == "exit" || $cmd == "bye" }  {
		set end_of_output 1
	}

  while { $end_of_output == 0 } {
    expect {
      -re ".*(#|# |>|> |\]#)$residual_cmd\$"   {
        # puts "\n--- ST0:<$expect_out(0,string)>"
        # puts "\n--- ST1:<$expect_out(1,string)>"
        append res $expect_out(buffer)
        if { [string length $residual_cmd] > 0 } {
          # Delete the whole string
          for { set i 0 } { $i < [string length $residual_cmd] } { incr i } {
     send "[format "%c" 8]"
          }
        }
        set end_of_output 1
      }
      -re ".*--More--.*" {
        send " "
        append res $expect_out(buffer)
      }

      ##
      # For Importing Cert/Key pair ( ACNS5.1 HTTPS Caching )
      ##
      -re "Enter Import Password:" {
             send "$passwd\n"
             append res $expect_out(buffer)
             expect {
                        -re "Enter PEM pass phrase:" {
                                  send "$passwd\n"
                                  append res $expect_out(buffer)
                                  expect {
                                        -re "Verifying password - Enter PEM pass phrase:" {
                                                send "$passwd\r"
                                                append res $expect_out(buffer)
                                         }
                                        -re "#|>" { send "\r" }
                                  }
                        }
                        -re "#|>" { send "\r" }
             }
       }

	-re ".*Enter username for remote ftp server:" {
        send "$user\n"
        append res $expect_out(buffer)
        expect {
            -re ".*Enter password for remote ftp server:" {
            send "$passwd\n"
                append res $expect_out(buffer)
            expect {
                -re ".*Are you sure you want to go ahead" {
                after 5
                send "yes\n"
                append res $expect_out(buffer)
                expect {
                    -re "The new software will run after you reload." {
                    puts "@@@@@@@@@@@ Software loaded successfully @@@@@@@@@@@"
					set end_of_output 1
                        }
                    }
                }
                -re "The new software will run after you reload." {
                puts "@@@@@@@@@@@ Software loaded successfully @@@@@@@@@"
                set end_of_output 1
                    }
                    }
            }
        }
    }
	
      -re ".*\[pP]roceed*" {
        send "yes\n"
        append res $expect_out(buffer)
      }


# Added this regular expression for "cms deregister force" to successfully execute
# the command by tcittara 
      -re ".*junkcontinue*" {
        send "yes\n"
        append res $expect_out(buffer)
      }

	timeout      {
        set end_of_output 1
	}
	-re ".*no]" {
	send "yes\n"
	append res $expect_out(buffer)
	}
  } ;#end expect


 } ;#end while

return [eliminate_nonascii $res]



}; # proc se_cli

#==============================================n


# ------------------------------------------------------------------------------
# Proc: se_close
# 
# Closes a conection open with se_connect
#
# Params:
#   cd = Connection descriptor
#
proc se_close { cd } {

  se_prompt $cd # 

  set spawn_id $cd
  after 200
  send -- "\035"
  after 200
  send "close \r"
  close

  wait

  # This value should be increased if the console connections close slowly
  after 200

}; # proc se_close
############################################################
# function :
# se_upgrade_all
# return :
# 1 -- success
# -1 -- fail
############################################################
proc se_upgrade_all {hostlist ftp_addr dir filename {user_name ftp} {passwd vcnbu}} {
	upvar  $hostlist myhostlist
	set copyflag 0
	foreach myhost_i [keylkeys myhostlist] {
			set spawn_id [keylget myhostlist $myhost_i.connectionid]
			#puts "spawn_id = $spawn_id"
			keylset id_hostname_list $spawn_id.hostname $myhost_i
			lappend spawn_ids $spawn_id
			send "copy ftp install $ftp_addr $dir $filename\r"
	}
	set devices_count [llength $spawn_ids]
	puts "spawn_ids = $spawn_ids"
	set timeout 600
	while {$devices_count>0} {
			expect {
					-i $spawn_ids "Enter username for remote ftp server: " {
							puts "*1**$expect_out(spawn_id)***"
							send -i $expect_out(spawn_id) "$user_name\r"
							exp_continue
					}
					-i $spawn_ids "Enter password for remote ftp server: " {
							puts "*2**$expect_out(spawn_id)***"
							send -i $expect_out(spawn_id) "$passwd\r"
							exp_continue
					}
					-i $spawn_ids -re "The new software will run after you reload." {
							puts "copy ftp intall is OK ,you need reload it."
							puts "*3*$expect_out(spawn_id)***"
							send -i $expect_out(spawn_id) "reload\r"
							exp_continue
					}
					-i $spawn_ids -re "System configuration has been modified. Save\?.*yes.*:" {
							send -i $expect_out(spawn_id) "\r"
							exp_continue
					}
					-i $spawn_ids -re "Proceed with reload\?.*" {
							send -i $expect_out(spawn_id) "\r"
							puts "in grogress of reload..."
							#set timeout 600
							exp_continue
					}
					-i $spawn_ids -re "##" {
							#puts "**$expect_out(spawn_id)**"
							exp_continue
					}
					-i $spawn_ids "Cisco Content Delivery System Manager Console" {
							puts "CDSM upgrade success!"
							incr devices_count -1
							set tmp_hostname [keylget id_hostname_list $expect_out(spawn_id).hostname]
							keylset myhostlist $tmp_hostname.upgradeflag "DONE"
					}
					-i $spawn_ids "Cisco Service Router Console" {
							puts "SR upgrade success!"
							incr devices_count -1
							set tmp_hostname [keylget id_hostname_list $expect_out(spawn_id).hostname]
							keylset myhostlist $tmp_hostname.upgradeflag "DONE"
					}
					-i $spawn_ids "Cisco Service Engine Console" {
							puts "SE upgrade success!"
							incr devices_count -1
							set tmp_hostname [keylget id_hostname_list $expect_out(spawn_id).hostname]
							keylset myhostlist $tmp_hostname.upgradeflag "DONE"
					}
					timeout {
							puts "copy ftp install timeout"
							break
					}
			}
			puts "complete one"
	}


	return 1

}


proc test_se_upgrade_all {} {
	set cd1 [se_console 10.74.61.3 2076]
	set cd2 [se_console 10.74.61.2 2010]
	keylset tempkeylist se1.connectionid $cd1
	keylset tempkeylist se2.connectionid $cd2
	se_upgrade_all tempkeylist "10.74.61.98" "/pub/project/spcdn/bin/release_builds/cds_2.0.0-b410/i386/" "cds-ims-32.bin"
	puts [keylget tempkeylist se1.upgradeflag]
	puts [keylget tempkeylist se2.upgradeflag]
}
test_se_upgrade_all
