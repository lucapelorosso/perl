#!/usr/bin/perl
use strict;
use warnings;

# Controlla che l'utente abbia passato due argomenti:
# 1) il file da leggere
# 2) la stringa da cercare
if (@ARGV != 2) {
    die "Uso: $0 <file> <stringa>\n";
}

my ($file, $stringa) = @ARGV;

# Apri il file in lettura
open(my $fh, '<', $file) or die "Non posso aprire '$file': $!";

# Leggi riga per riga
while (my $line = <$fh>) {
    chomp $line;
    if ($line =~ /\Q$stringa\E/) {
        print "$line\n";
    }
}

close $fh;