#!/bin/perl -w

use strict;

my @files = <*.log>;

foreach my $file (@files) {

   my %threads = ();

   # get all the unique thread IDs for lines containing transaction data based on the headers in one file
   # and put them in hash %threads
   open(LOGFILE,$file) or warn("Could not open log file.");
   while (<LOGFILE>) {
      if ( m/.{10}\s.{12}\s(.\w+.)Authentication Request/ | m/.{10}\s.{12}\s(.\w+.)Authentication Response/ | m/.{10}\s.{12}\s(.\w+.)Accounting Request/ ) {
         unless (exists $threads{ $1 }) {
            $threads{ $1 } = '1'; # '1' just to put something in there
         }
      }
   }
   close(LOGFILE) or warn("Could not close log file: $file.");
   
   # loop through the file once for each key in hash %threads
   foreach my $thread (keys (%threads)) {
      open(LOGFILE,$file) or warn("Could not open log file.");
      TRANSACTION: while (<LOGFILE>) {   
     
         my %transaction = ();
       
         # if a line is found with the current thread ID and Authentication Request header...
         if ( m/(.{10}\s.{12})\s\($thread\)Authentication Request/ ) {
            $transaction{ 'timestamp' } = $1;
            $transaction{ 'thread' } = $thread;
            $transaction{ 'type' } = "Request";
         # read each subsequent line to build transaction
         while (<LOGFILE>) {
               if ( m/.{10}\s.{12}\s\($thread\)Acct-Session-Id : String Value = (.*$)/ ) {
                  $transaction{ 'Acct-Session-Id' } = $1;
               } elsif ( m/.{10}\s.{12}\s\($thread\)User-Name : String Value = (.*$)/ ) {
                  $transaction{ 'User-Name' } = $1;
               } elsif ( m/(.{10}\s.{12})\s\($thread\)Authentication Request/ | m/(.{10}\s.{12})\s\($thread\)Authentication Response/ | m/(.{10}\s.{12})\s\($thread\)Accounting Request/) {
                  # if a new transaction header is found, do something with the transaction and redo the line
                  print map { "$_ => $transaction{$_}\n" } keys %transaction;
                  redo TRANSACTION; 
               }
            }
            print map { "$_ => $transaction{$_}\n" } keys %transaction;
         } elsif ( m/(.{10}\s.{12})\s\($thread\)Authentication Response/ ) { 
         # or Authentication Response...
            $transaction{ 'timestamp' } = $1;
            $transaction{ 'thread' } = $thread;
            $transaction{ 'type' } = "Reponse";
            # read each subsequent line to build transaction
            while (<LOGFILE>) {
               if ( m/.{10}\s.{12}\s\($thread\)Acct-Session-Id : String Value = (.*$)/ ) {
                  $transaction{ 'Acct-Session-Id' } = $1;
               } elsif ( m/.{10}\s.{12}\s\($thread\)User-Name : String Value = (.*$)/ ) {
                  $transaction{ 'User-Name' } = $1;
               } elsif ( m/(.{10}\s.{12})\s\($thread\)Authentication Request/ | m/(.{10}\s.{12})\s\($thread\)Authentication Response/ | m/(.{10}\s.{12})\s\($thread\)Accounting Request/) {
                  # if a new transaction header is found, do something with the transaction and redo the line
                  print map { "$_ => $transaction{$_}\n" } keys %transaction;
                  redo TRANSACTION;
               }
            }
            print map { "$_ => $transaction{$_}\n" } keys %transaction;
         } elsif ( m/(.{10}\s.{12})\s\($thread\)Accounting Request/ ) { 
            # or Accounting Request...
            $transaction{ 'timestamp' } = $1;
            $transaction{ 'thread' } = $thread;
            $transaction{ 'type' } = "Accounting";
            # read each subsequent line to build transaction
            LINE: while (<LOGFILE>) {
               if ( m/.{10}\s.{12}\s\($thread\)Acct-Session-Id : String Value = (.*$)/ ) {
                  $transaction{ 'Acct-Session-Id' } = $1;
               } elsif ( m/.{10}\s.{12}\s\($thread\)User-Name : String Value = (.*$)/ ) {
                  $transaction{ 'User-Name' } = $1;
               } elsif ( m/(.{10}\s.{12})\s\($thread\)Authentication Request/ | m/(.{10}\s.{12})\s\($thread\)Authentication Response/ | m/(.{10}\s.{12})\s\($thread\)Accounting Request/) {
                  # if a new transaction header is found, do something with the transaction and redo the line
                  print map { "$_ => $transaction{$_}\n" } keys %transaction;
                  redo TRANSACTION;
               }
            }
            print map { "$_ => $transaction{$_}\n" } keys %transaction;
         }
      }
      close(LOGFILE) or warn("Could not close log file: $file.");
   }
}

