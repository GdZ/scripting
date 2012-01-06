

set OriginFqdn_Name2          wmt-os.auto.com
set OriginFqdn_dss			  dss-os.auto.com
set Fqdn_Name1                we.auto.com
set Fqdn_Name2                wmt.auto.com
set url rtsp://wmt.auto.com/snowboard_100.wmv
set url_index [string first $Fqdn_Name2 $url]
if {$url_index == -1} {
	puts "Error in search url"
}
set url_last [expr $url_index+[string length $Fqdn_Name2]-1]
set out [string replace $url $url_index $url_last $OriginFqdn_Name2]
puts "$out"
puts "$OriginFqdn_Name2"
