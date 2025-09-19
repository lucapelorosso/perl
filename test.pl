#!/usr/bin/perl

use strict;
use warnings;

print "Ciao dal tuo primo script Perl su macOS!\n";


my $filename = "/private/tmp/prova.txt";
print "Scrittura completata su $filename  scrittura (>)" ;
# oppure in modalità aappend(>>)
open(my $fh, '>', $filename) or die "Non posso aprire il file '$filename': $!";

# Scrivi del contenuto nel file
print $fh "Ciao, questo è un testo scritto con Perl!\n";
print $fh "Seconda riga di esempio.\n";

# Chiudi il file
close($fh);

print "Scrittura completata su $filename\n";
