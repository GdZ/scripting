my @dirlist = glob "/data/Capacity-Monitoring-logs/20110617/output-*";
my @filelist = ();
foreach my $list_i (@dirlist) {
#print "list is $list_i";
my @listfiles = glob "$list_i/*-top.out";
@filelist = (@filelist,@listfiles);
}

foreach my $list_j(@filelist) {
print "list is $list_j \n";
}
