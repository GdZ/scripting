use Expect;
use Tk;
my @nodelist;
my $node_cdsm = {
	cds_role=>"CDSM",
	hostname=>"R2-WAE611-6",
	ipaddr=>"11.0.0.16",
	ext_ip=>"10.74.61.100",
	platform_type=>"32bit",
	console_connection=>"10.74.61.2:2004",
	reboot_connection=>"10.0.0.1"
};
my $node_sr = {
	cds_role=>"SR",
	hostname=>"R1-WAE611-4",
	ipaddr=>"10.0.0.14",
	ext_ip=>"10.74.61.100",
	platform_type=>"32bit",
	console_connection=>"10.74.61.2:2004",
	reboot_connection=>"10.0.0.1"
};
my $node_se1 = {
	cds_role=>"SE",
	hostname=>"R1-WAE611-5",
	ipaddr=>"10.0.0.15",
	ext_ip=>"10.74.61.100",
	platform_type=>"32bit",
	console_connection=>"10.74.61.2:2004",
	reboot_connection=>"10.0.0.1"
};
my $node_se2 = {
	cds_role=>"SE",
	hostname=>"R3-WAE611-4",
	ipaddr=>"12.0.0.14",
	ext_ip=>"10.74.61.100",
	platform_type=>"32bit",
	console_connection=>"10.74.61.2:2004",
	reboot_connection=>"10.0.0.1"
};
my $node_se3 = {
	cds_role=>"SE",
	hostname=>"R3-WAE611-6",
	ipaddr=>"12.0.0.16",
	ext_ip=>"10.74.61.100",
	platform_type=>"32bit",
	console_connection=>"10.74.61.2:2004",
	reboot_connection=>"10.0.0.1"
};
my $node_se4 = {
	cds_role=>"SE",
	hostname=>"R2-WAE611-3",
	ipaddr=>"11.0.0.13",
	ext_ip=>"10.74.61.100",
	platform_type=>"32bit",
	console_connection=>"10.74.61.2:2004",
	reboot_connection=>"10.0.0.1"
};
@nodelist = ($node_cdsm,$node_sr,$node_se1,$node_se2,$node_se3,$node_se4);

my $image_32bit = {
	ftp_ip =>"10.74.61.98",
	dir =>"/pub/project/spcdn/bin/release_builds/cds_2.0.0-b400/i386/",
	filename =>"cds-ims-32.bin"
};
my $image_64bit = {
	ftp_ip =>"10.74.61.98",
	dir =>"/pub/project/spcdn/bin/release_builds/cds_2.0.0-b400/x86_64/",
	filename =>"cds-ims-64.bin"
};


$mw = MainWindow->new;

my $menu_bar = $mw->Frame()->pack('-side'=> 'top', '-fill' => 'x');
my $command_mb = $menu_bar->Menubutton ('-text'         => 'Command',
                                          '-relief'       => 'raised',
                                          '-borderwidth'  => 2,
                                          )->pack('-side' => 'left',
                                                  '-padx' => 2
                                               );

 $command_mb->separator();
 $command_mb->command('-label' => 'upgrade',
 						'-underline' =>0,
 						'-command' => \&upgrade_device
 						);
 						

my $frame = $mw->Frame()->pack();
$frame->Label(-text=>"DevicesList");
$hostslist = $frame->Listbox('-width'=>80,'-height'=>10,'-selectmode'=>'multiple')->pack();
foreach $node (@nodelist) {
	$hostslist->insert('end',"$node->{ipaddr}:$node->{hostname}:$node->{cds_role}");
};
my $insert_hostentry = $frame->Entry('-width'=>80)->pack();
my $inset_enter = $frame->Button(-text=>"Add Host!",-command=>\&add_deviceip)->pack();
my $hostslist_selected = $frame->Listbox('-width'=>80,'-height'=>10,'-selectmode'=>'multiple')->pack();
my $select = $mw -> Button(-text=>"-->", -command =>\&select_device)->pack();
my $deselect = $mw -> Button(-text=>"<--", -command =>\&deselect_device)->pack();
my $upgrade = $mw -> Button(-text=>"Upgrade", -command =>\&upgrade_device)->pack();
my $frm_imagetype = $frame -> Frame()->pack();
my $lbl_gender = $frm_imagetype -> Label(-text=>"image type")->pack();
my $rdb_64 = $frm_imagetype -> Radiobutton(-text=>"64bit",  
		-value=>"64",  -variable=>\$image_type)->pack();
my $rdb_32 = $frm_imagetype -> Radiobutton(-text=>"32bit",
		-value=>"32",-variable=>\$image_type)->pack();
my $image64entry = $frame->Entry('-width'=>80)->pack();
$image64entry->insert("end","ftp://$image_64bit->{ftp_ip}/$image_64bit->{dir}/$image_64bit->{filename}");

my $image32entry = $frame->Entry('-width'=>80)->pack();
$image32entry->insert("end","ftp://$image_32bit->{ftp_ip}/$image_32bit->{dir}/$image_32bit->{filename}");
sub add_deviceip {
	my $hostip = $insert_hostentry->get();
	$hostslist_selected->insert('end',$hostip);
}
sub select_device {
	my @host_ids = $hostslist->curselection();
	foreach (@host_ids) {
		my $hostname = $hostslist -> get($_);
		my @hostentry = split /:/,$hostname;
		my $hostip = $hostentry[0];
		$hostslist_selected->insert('end',$hostip);
	}
	
}
sub deselect_device {
	my @host_ids = $hostslist_selected->curselection();
	#my $hostname = $hostslist_selected ->delete(@host_ids);
	foreach (@host_ids) {
		print "***$_***";
		$hostslist_selected ->delete($_);
	}
	my $tmp = $hostslist_selected->index('end');
	print "\ncount of list is $tmp";
}
sub test_upgrade_device {
	my $image_info;
	if($image_type == 64) {
		$image_info = $image64entry->get();
	} else {
		$image_info = $image32entry->get();
	}
	print "\n$image_info\n";
	my ($ftp_ip,$dd,$ff,$dir,$cc,$filename) =($image_info =~m%ftp://((\w+\.)*(\w*))/+(([\w\.-]+/?)+)/+(.*)$% );
	print "\n=$ftp_ip=$dir=$filename\n";
}
sub upgrade_device {
	my $timeout = 30;
	my $host_id = $hostslist_selected->curselection();
	my $hostip = $hostslist_selected -> get($host_id);
	print "***Hostname is $hostip***\n";
	my $image_info;
	if($image_type == 64) {
		$image_info = $image64entry->get();
	} else {
		$image_info = $image32entry->get();
	}
	my ($ftp_ip,$dd,$ff,$dir,$cc,$filename) =($image_info =~m%ftp://((\w+\.)*(\w*))/+(([\w\.-]+/?)+)/+(.*)$% );
	#my ($ftp_ip,$dir,$filename) =($image_info =~ m%ftp://(.*)/+(.*)/(\.bin)% );
	my $connect_id =connect_box($hostip,23);
	$connect_id->send("show version\n");
 $connect_id->expect($timeout,
 [
 '-re',qr'[#]$',
 sub {
 	#my $fh = shift;
 	my $str_out = $connect_id->before();
 	print  "***$str_out***\n";
 }
 ],
 timeout =>
 sub {
 	die "time out\n";
 },
 );
 $connect_id->send("copy ftp install $ftp_ip $dir $filename\n");
 $timeout = 600;
 $connect_id->expect($timeout,
 [ 'Enter username for remote ftp server: ',
 sub {
 	my $myself = shift;
 	$myself->send("anonymous\r");
 	exp_continue;
 }
 ],
 ['Enter password for remote ftp server: ',
 sub {
 	my $myself = shift;
 	$myself->send('hailwang@cisco.com');
 	$myself->send("\r");
 	exp_continue;
 }
 ],
 ['The new software will run after you reload',
 sub {
 	my $myself = shift;
 	$myself->send("\r");
 	print "copy ok\n";
 }
 ],
 ['Upgrade failed',
 sub {print "fail\n";}
 ],
 [
   timeout =>
                sub {
                  die "Timeout 600s,No login.\n";
                }
               ]
 );
 $connect_id->send("reload\n");
 $timeout = 15;
 $connect_id->expect($timeout,
 [ 'Proceed with reload\?\[confirm\]',
 sub {
 	#print "debug\n";
 	my $myself = shift;
 	$myself->send("\n");
 	exp_continue;
 }
 ],
 [ 'System configuration has been modified. Save\?\[yes\]:',
 sub {
 	my $myself = shift;
 	$myself->send("\n");
 	exp_continue;
 }
 ],
 [
   timeout =>sub {
                  print "Timeout.\n";
                }
 ],
 'reload in progress ..',
 );
 print "Here\n";
}


sub create_hostwindow {
	my ($host,$hostname) = @_;

my $output_t = $host->Scrolled('Text');
$output_t->pack(-expand =>1,-fill => 'both');
my $bind_hl = "TEXT_$hostname";

tie (*$bind_hl, 'Tk::Text',$output_t);
$host->Label( -text => "$hostname" )->pack('-side' => 'left');
my $show = $host->Entry ('-width' => 20,)->pack('-side' => 'left');
#$show->bind('<KeyPress-Return>',\&show_ver);
my $botton_go = $host->Button(
	-text => 'show',
	-command =>sub{show_ver($bind_hl,$hostname)}
	)->pack;
}
sub connect_box {
	my ($host,$port) = @_;
my $command = "telnet $host $port";
my $exp = Expect->spawn($command);
my $timeout = 30;
my $spawn_ok; 
my $username = "admin";
my $password = "default";

 $exp->expect( $timeout,
               [
                'login: $',
                sub {
                  $spawn_ok = 1;
                  my $fh = shift;
				print "Here username\n";
                  $fh->send("$username\n");
                  exp_continue;
                }
               ],
               [
                'Password: ',
                sub {
                  my $fh = shift;
                  print $fh "$password\n";
                  exp_continue;
                }
               ],
               [
                eof =>
                sub {
                  if ($spawn_ok) {
                    die "ERROR: premature EOF in login.\n";
                  } else {
                    die "ERROR: could not spawn telnet.\n";
                  }
                }
               ],
               [
                timeout =>
                sub {
                  die "Timeout 30s,No login.\n";
                }
               ],
               '-re', qr'[#]$', #' wait for shell prompt, then exit expect
              );
              return $exp;
}
sub show_ver {
my ($handle,$host,$port) = @_;
my $connect_id = connect_box($host,$port);
 $connect_id->send("show version\n");
 $connect_id->expect($timeout,
 [
 '-re',qr'[#]$',
 sub {
 	#my $fh = shift;
 	my $str_out = $connect_id->before();
 	print $handle "***$str_out***\n";
 }
 ],
 timeout =>
 sub {
 	die "time out\n";
 },
 );
}
MainLoop;
