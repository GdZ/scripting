proc u2a {s} {
    set res ""
    foreach i [split $s ""] {
        scan $i %c c
        if {$c<128} {append res $i} else {append res \\u[format %04.4X $c]}
    }
    set res
 } ;#RS

set fp [open "c.txt" r]
set file_data [read $fp]
puts [u2a $file_data]
if {[regexp -- {Playing} $file_data {}] || [regexp -- {\u64AD\u653E} $file_data {}]} {
puts "Good"
}

close $fp
puts $file_data
