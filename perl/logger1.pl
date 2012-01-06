#!/bin/perl -w

use strict;
use List::Util qw(min max);
#How to get host name list 
my @allfiles = glob "/home/hailiang/cds/*-top.out";
my %ufilenames = ();
foreach my $tmpfile (@allfiles) {
	$tmpfile =~ m/\/([-\w]+)-\d{8}-\d{6}-top\.out/;
	if (exists $ufilenames{$1}) {
		next;
	} else {
		$ufilenames{$1} = "YES";
	}
}

for my $host_name ( keys %ufilenames ) {
	print "for $host_name\n";

#my $host_name = "ken-cdn220-is-2";
	open(RESULT,">$host_name.csv") or warn("could not open file top_output");
	print RESULT "DATE,TIME,DS,WE,WMT-BME,WMT-CORE,WMT-BE\n";
	my @files = </home/hailiang/cds/$host_name-*-top.out>;
	foreach my $file (@files) {
		print "Dealing with file $file \n";
		$file =~ m/$host_name-(\d+)-(\d{2})(\d{2})(\d{2})-top/;
		my $date = $1;
		my $hour = $2 + 10;
		if ($hour >= 24) {
			$date += 1;
			$hour -= 24;
		}
		print RESULT "$date,$hour:$3:$4,";
		my %cpus = ("web-engine",0,"dataserver",0,"wmt_be",0,"wmt_be-1",0,"wmt_be-2",0,"wmt_be-0",0 \
			,"wmt_mbe-0",0,"wmt_mbe-1",0,"wmt_mbe-2",0,"wmt_mbe",0,"wmt-core",0);

		open(LOGFILE,$file) or warn("Could not open log file.");
		my $top_sections = -1;
		while (<LOGFILE>) {
			if ( m/^Tasks:/ ) {
				$top_sections ++;
				print "Section $top_sections \n";
				next;
			}

			if ( m/\d+\s\w\s{3,4}(\d+)\s{2}[\.\d]+\s+[\.:\d]+\s{1}web-engine/ ) {
				my $section_i = $top_sections%3;
				print "Top $section_i web-engine CPU == $1 == \n";
				if ($cpus{"web-engine"} < $1) {
					$cpus{"web-engine"} = $1;
				}
				next;
			}
			if ( m/\d+\s\w\s{3,4}(\d+)\s{2}[\.\d]+\s+[\.:\d]+\s{1}dataserver/ ) {
				my $section_i = $top_sections%3;
				print "Top $section_i dataserver CPU == $1 == \n";
				if ($cpus{"dataserver"} < $1) {
					$cpus{"dataserver"} = $1;
				}
				next;
			}
			if ( m/\d+\s\w\s{3,4}(\d+)\s{2}[\.\d]+\s+[\.:\d]+\s{1}wmt_be/ ) {
				my $section_i = $top_sections%3;
				print "Top $section_i wmt_be CPU == $1 == \n";
				$cpus{"wmt_be-$section_i"} += $1;
				next;
			}
			if ( m/\d+\s\w\s{3,4}(\d+)\s{2}[\.\d]+\s+[\.:\d]+\s{1}wmt_mbe/ ) {
				my $section_i = $top_sections%3;
				print "Top $section_i wmt_mbe CPU == $1 == \n";
				$cpus{"wmt_mbe-$section_i"} += $1;
				next;
			}
			if ( m/\d+\s\w\s{3,4}(\d+)\s{2}[\.\d]+\s+[\.:\d]+\s{1}wmt_core/ ) {
				my $section_i = $top_sections%3;
				print "Top $section_i wmt_core CPU == $1 == \n";
				if ($cpus{"wmt_core"} < $1) {
					$cpus{"wmt_core"} = $1;
				}
				next;
			}
		}

		$cpus{"wmt_be"} = max($cpus{"wmt_be-0"},$cpus{"wmt_be-1"},$cpus{"wmt_be-2"});
		$cpus{"wmt_mbe"} = max($cpus{"wmt_mbe-0"},$cpus{"wmt_mbe-1"},$cpus{"wmt_mbe-2"});
		print RESULT $cpus{"dataserver"};
		print RESULT ",";
		print RESULT $cpus{"web-engine"};
		print RESULT ",";
		print RESULT $cpus{"wmt_bme"};
		print RESULT ",";
		print RESULT $cpus{"web-core"};
		print RESULT ",";
		print RESULT $cpus{"wmt_be"};
		print RESULT "\n";
		close(LOGFILE) or warn("Could not close log file: $file.");

	}


close(RESULT) or warn("Could not close log file: $host_name.");
}
