#!/usr/bin/perl
use strict;
use warnings;

my $file_output = "test_output.txt";

# Apri il file in scrittura (>) sovrascrive, (>>) aggiunge in fondo
open(my $fh, '>', $file_output) or die "Non posso aprire $file_output: $!";

print $fh "Ciao, questo è il mio testo\n";
print $fh "Altra riga di esempio\n";

close $fh;

print "Scrittura completata in $file_output\n";

