use Expect;
my $command = "telnet 11.0.0.16";
my $exp = Expect->spawn($command);
my $timeout = 10;
my $spawn_ok; 
my $username = "admin";
my $password = "default";
#sleep 2;
 $exp->expect($timeout,
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
                  die "No login.\n";
                }
               ],
               '-re', qr'[#>:] $', #' wait for shell prompt, then exit expect
              );


