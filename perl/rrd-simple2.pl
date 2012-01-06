 use strict;
 use RRD::Simple;
 
 my $rrdfile = "vmstat-cpu.rrd";
 my $rrd = RRD::Simple->new( file => $rrdfile );
 
 $rrd->graph(
         title => "CPU Utilisation",
         vertical_label => "% percent",
         upper_limit => 100,
         lower_limit => 0,
         rigid => "",
         sources => [ qw(sy us wa id) ],
         source_drawtypes => [ qw(AREA STACK STACK STACK) ],
         extended_legend => 1,
     );
