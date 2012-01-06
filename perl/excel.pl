    #!/usr/bin/perl -w

    use strict;
    use Spreadsheet::WriteExcel;

    # Create a new Excel workbook called perl.xls

    my $workbook = Spreadsheet::WriteExcel->new("perl.xls");

    my $worksheet = $workbook->addworksheet();

    # Write some text and some numbers
    # Row and column are zero indexed
    $worksheet->write(0, 0, "The Perl Journal");
    $worksheet->write(1, 0, "One"            );
    $worksheet->write(2, 0, "Two"            );
    $worksheet->write(3, 0,  3               );
    $worksheet->write(4, 0,  4.0000001        );
