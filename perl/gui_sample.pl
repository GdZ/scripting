#!/usr/bin/perl -w
use Tk;
$mw = MainWindow->new;
my $output_t = $mw->Scrolled('Text');
$output_t->pack(-expand =>1,-fill => 'both');
tie (*TEXT, 'Tk::Text',$output_t);
print TEXT 'Hi the\n';

$text = $mw->Text ('-width' => 80,
		'-height' => 40)->pack();
$mw->Label( -text => "telnet show:" )->pack('-side' => 'left');
$show = $mw->Entry ('-width' => 20,)->pack('-side' => 'left');
$show->bind('<KeyPress-Return>',\&show_cli);
#$mw->Button( -text => "Exit", -command => sub { exit } )->pack;
MainLoop;
sub show_cli {
print "Here cli\n";
}
