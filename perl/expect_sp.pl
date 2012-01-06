use Net::Telnet;
use Expect;
my $host="11.0.0.2";
my $telnet = new Net::Telnet() # see Net::Telnet
    or die "Cannot telnet to remotehost: $!\n";
$telnet->open("11.0.0.2");
  my $exp = Expect->init($telnet);
$exp->log_file("tmp.out");
my $spawn_ok;
my $timeout = 10;
my $username = "admin";
my $password = "default";
#sleep 10;

my $out= $exp->before();
print "***$out***";
  $exp->expect($timeout,
               [
                'login:',
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
                  die "No login.\n";
                }
               ],
               '-re', qr'[#>:] $', #' wait for shell prompt, then exit expect
              );
