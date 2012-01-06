use Expect;
use Tk;
$mw = MainWindow->new;
my $host1 = $mw->Toplevel;
$host1_name = "12.0.0.14";
$host2_name = "12.0.0.16";
create_hostwindow($host1,$host1_name);
my $host2 = $mw->Toplevel;
create_hostwindow($host2,$host2_name);

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
	my ($host) = @_;
my $command = "telnet $host";
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
my ($handle,$host) = @_;
my $connect_id = connect_box($host);
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
