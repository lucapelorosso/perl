#!/usr/bin/perl
use strict;
use warnings;

my %max_record;
my $day    = "01";
my $month  = "01";
my $year   = "1900";
my $lenConsegna = 0;

while (<>) {
    chomp;
    my @fields = split /\|/, $_, -1;
    # prendo la colonna richiesta (1-based)
    my $key = $fields[2] // ''; # primo campo = chiave
    #my $key   = $fields[2];   # primo campo = chiave
    my $value = $fields[4] // ''; # secondo campo = valore

    
    if (defined $fields[4] && $fields[4] ne '') {
       $lenConsegna = length($fields[4]);
       $value = $fields[4];

       if ($lenConsegna==7) {
          $value="0$fields[4]";
       }  
       if ($value =~ /^(\d{2})(\d{2})(\d{4})$/) {
        
         my ($day, $month, $year) = ($1, $2, $3);
         $day = sprintf("%02d", $day);
         $month   = sprintf("%02d", $month);         
         $value  = "$year-$month-$day";
         # print "Data Consegna $campi[4] \n";
        }       
    }
    else { 
         $day    = "01";
         $month  = "01";
         $year   = "1900";
         $value  = "$year-$month-$day";
    }
    # Se non esiste ancora la chiave o il nuovo valore è maggiore, aggiorna
    if ( !exists $max_record{$key} || $value > $max_record{$key}{value} ) {
        $max_record{$key} = { value => $value, line => $_ };
    }
    # printf "Data Consegna: $value \n";
    # printf "Data Consegna file: $fields[4] \n";
}

# Stampa solo i record con valore massimo
foreach my $k (keys %max_record) {
    printf $max_record{$k}{line}, "\n";
}