#!/usr/bin/perl
use 5.010;
my $str = "dsdsdsddddd";
print "===$0===\n";
print "===$PROGRAM_NAME===\n";
print "===$ARGV[0]===\n";
#$str =~ s/d{3}/U{3}/g;
#print $str;
$str .= "##";


say "Herry 10.0 $str";

my @a = (1,2,3);
my @b = (4,5,6);
my @c = (@a,@b);
foreach (@c) {
	say;
}

my $v_1 = 12;
my $v_2 = "12";

my $v_3 = 13;
my $v_4 = "13";
if( $v_1 == $v_2 ) {
say " == ";
};

if ($v_1 eq $v_2 ) {
say " eq ";
};

if( $v_1 < $v_3 ) {
say " < ";
};

if ($v_1 lt $v_4 ) {
say " lt ";
};


my $rex_exp = "http://(.*)\.c\.youtube\.com/(.*)/(.*?)\?(.*?)(id=[0-9a-zA-Z]+)";
my $myurl= "http://ott.c.youtube.com/cache12.youtube.com/videoplayback?params=sparams=id&&ip=1.2.3.4&id=abcd";

$myurl =~ $rex_exp;
say "REX output: ";
say $1;
say $2;
say $3;
say $4;


my $str_test = "dfdud?1234";
$str_test =~ "(.*)\?1234";
say $1;
