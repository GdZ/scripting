 use strict;
 use RRD::Simple;
 
 my $cmd = "/usr/bin/vmstat 2 3";
 my $rrdfile = "vmstat-cpu.rrd";
 my $rrd = RRD::Simple->new( file => $rrdfile );
 
 my @keys = ();
 my %update = ();
 open(PH,"-|",$cmd) or die qq{Unable to open file handle PH for command "$cmd": $!};
 while (local $_ = <PH>) {
     next if /---/;
     s/^\s+|\s+$//g;
     if (/\d+/ && @keys) {
         @update{@keys} = split(/\s+/,$_);
     } else { @keys = split(/\s+/,$_); }
 }
 close(PH) or die qq{Unable to close file handle PH for command "$cmd": $!};
 
 my @cpukeys = splice(@keys,-4,4);
 my %labels = (wa => "IO wait", id => "Idle", sy => "System", us => "User");
 
 $rrd->create(map { ($_ => "GAUGE") } @cpukeys) unless -f $rrdfile;
 $rrd->update(map { ($_ => $update{$_}) } @cpukeys);
