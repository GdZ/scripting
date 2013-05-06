#!/usr/bin/perl
#

#
#
#/opt/GeoDirectory/bin
#./startserver
$STATE_OK=0;
$STATE_WARNING=1;
$STATE_CRITICAL=2;
$STATE_UNKNOWN=3;
$STATE_DEPENDENT=4;


sub print_usage() {
	print "Usage: check_quova";
	print "Usage: check_quova --help";
};

sub print_help() {
	print "";
	print_usage();
	print "";
	print "Quova Service monitor plugin for Nagios";
	print "";
	print "This plugin not developped by the Nagios Plugin group.";
	print "Please do not e-mail them for support on this plugin, since";
	print "they won't know what you're talking about :P";
	print "";
	print "For contact info, read the plugin itself...";
}

my $cmd_op =  $ARGV[1] ;
if ($cmd_op eq "--help") { print_help(); exit $STATE_OK;}
elsif ($cmd_op eq "-h") { print_help(); exit $STATE_OK;}
else { 
}
sub check_processes()
{
	my $PROCESS="0";
	my $lineofpro = `ps -ef | grep quo | grep -v grep | wc -l`;
	if($lineofpro != 2) { 
		print "FMS NOT OK - One or more processes not running, total we have 4";
		$exitstatus=$STATE_CRITICAL;
		exit $exitstatus;
	}
}
sub check_service()
{
        my $SERVICE=0;
	my $quo_ver = "";;
	my $quo_labdata = "";;
	my $quo_queries = "";;
	my $output=`/opt/GeoDirectory/bin/serverStats`;
	if($output =~ /version\s+([\.\d]+)/) {
		$quo_ver = $1;
	}
	if($output =~ /LabAddrs Data Release:\s+(\d+)/) {
		$quo_labdata = $1;
	}
	if($output =~ /Queries:\s+(\d+)/) {
		$quo_queries = $1;
	}
        if($quo_ver==""||$quo_labdata==0) {
                print "Quova NOT OK - Can't get ver and labdata";
                $exitstatus=$STATE_CRITICAL;
                exit $exitstatus;
        }
}

check_processes();
check_service();
print "FMS OK - 4 Process is running";
$exitstatus=$STATE_OK;
exit $exitstatus;
