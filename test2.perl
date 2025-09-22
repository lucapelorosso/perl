#!/usr/bin/perl -w
#
# Programma area-01.pl
# Scritto da Luca Pelorosso
#
# Programma per trovare l'area di un rettangolo.

print ("Inserisci la base: ");
$base = <STDIN>;
print ("Inserisci l'altezza: ");
$altezza = <STDIN>;             
$area = $base * $altezza;
print ("Il rettangolo con una base di ");
print $base;
print (" e un'altezza di ");
print $altezza;
print (" ha un'area di ");
print $area;
print ("\n");
