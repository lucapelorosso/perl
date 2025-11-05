#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $col = 3;   # colonna da usare (Contatore da 1)
GetOptions("col=i" => \$col) or die "Uso: $0 [--col=N] file\n";
die "Errore: --col deve essere >= 1\n" if $col < 1;

my @rows;
my @keys;
my %last_pos;

my $contatore = 1;
while (<>) {
    chomp;
    push @rows, $_;
    my $col = 3; 
    # divido la riga in campi usando il separatore |
    my @fields = split /\|/, $_, -1;
    # prendo la colonna richiesta (1-based)
    my $key = $fields[$col-1] // '';

    push @keys, $key;
    $last_pos{$key} = scalar(@rows);  # salva l'ultima posizione di questa chiave
    #print "Contatore $contatore - Last pos: $last_pos{$key} della chiave $key \n" if $last_pos{$key} != $contatore;;
    #$contatore = $contatore + 1;
}
# print "Linee totali: $#row\n";

# stampo solo le righe con l'ultima occorrenza della chiave
for my $i (0 .. $#rows) {
    my $line = $rows[$i];
    my $key  = $keys[$i];
    # print "Chiave: $keys[$i] con last pos $last_pos{$key} della linea $rows[$i] \n";
    print "$line\n" if $last_pos{$key} == $i + 1;
}
