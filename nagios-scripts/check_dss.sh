#!/bin/bash
#
# DNS / Named process monitor plugin for Nagios
# Written by Thomas Sluyter (nagios@kilala.nl)
# By request of DTV Labs, Liberty Global, the Netherlands
# Modified by Herry Wang, Cisco Corp
# Last Modified: 19-06-2006
# 
# Usage: ./check_named
#
# Description:
# This plugin determines whether the named DNS server
# is running properly. It will check the following:
# * Are all required processes running?
# * Is it possible to make DNS requests?
#
# Limitations:
# Currently this plugin will only function correctly on Solaris systems.
#
# Output:
# The script returns a CRIT when the abovementioned criteria are
# not matched.
#


# You may have to change this, depending on where you installed your
# Nagios plugins
#PATH="/usr/bin:/usr/sbin:/bin:/sbin"
#LIBEXEC="/usr/local/nagios/libexec"
# folloing is from . $LIBEXEC/utils.sh
# How to start DSS ?
#perl /usr/local/sbin/streamingadminserver.pl
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

if test -x /usr/bin/printf; then
        ECHO=/usr/bin/printf
else
        ECHO=echo
fi

print_revision() {
        echo "$1 v$2 (nagios-plugins 1.4.15)"
        $ECHO "The nagios plugins come with ABSOLUTELY NO WARRANTY. You may redistribute\ncopies of the plugins under the terms of the GNU General Public License.\nFor more information about these matters, see the file named COPYING.\n" | sed -e 's/\n/ /g'
}

support() {
        $ECHO "Send email to nagios-users@lists.sourceforge.net if you have questions\nregarding use of this software. To submit patches or suggest improvements,\nsend email to nagiosplug-devel@lists.sourceforge.net.\nPlease include version information with all correspondence (when possible,\nuse output from the --version option of the plugin itself).\n" | sed -e 's/\n/ /g'
}


print_usage() {
	echo "Usage: $PROGNAME"
	echo "Usage: $PROGNAME --help"
}

print_help() {
	echo ""
	print_usage
	echo ""
	echo "Darwin Service monitor plugin for Nagios"
	echo ""
	echo "This plugin not developped by the Nagios Plugin group."
	echo "Please do not e-mail them for support on this plugin, since"
	echo "they won't know what you're talking about :P"
	echo ""
	echo "For contact info, read the plugin itself..."
}

while test -n "$1" 
do
	case "$1" in
	  --help) print_help; exit $STATE_OK;;
	  -h) print_help; exit $STATE_OK;;
	  *) print_usage; exit $STATE_UNKNOWN;;
	esac
done

check_processes()
{
	PROCESS="0"
	if [ `ps -ef | grep DarwinStreamingServer | grep -v grep | wc -l` -ne 2 ]; then 
		echo "DSS NOT OK - One or more processes not running, total we have 2"
		exitstatus=$STATE_CRITICAL
		exit $exitstatus
	fi
}

check_processes

echo "DSS OK - 2 Process is running"
exitstatus=$STATE_OK
exit $exitstatus

