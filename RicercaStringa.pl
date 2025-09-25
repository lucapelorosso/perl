#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use File::Slurp qw(read_file);

# Testo da cercare: ho modificato con il testo da cercare come input
# my $testo_da_cercare = "transato"; # Prende il testo dal primo argomento della riga di comando
my ($testo_da_cercare) = @ARGV;



# Percorso della cartella in cui cercare
my $cartella_da_cercare = "."; # Inizia dalla cartella corrente
my $nome_file = "file.txt";
# my $fh;
my $contatore = 0;
unless (defined $testo_da_cercare) {
    die "Utilizzo: $0 <testo da cercare>\n";
}

print "Ricerca di \"$testo_da_cercare\" in \"$cartella_da_cercare\" e sottocartelle...\n\n";

# Usa File::Find per trovare tutti i file nella cartella e sottocartelle
find(sub {
    # Ignora le directory
    return unless -f;

    # Legge il contenuto del file
    my $contenuto_file;
    eval { $contenuto_file = read_file($_); }; # Gestisce eventuali errori di lettura
    if ($@) {
        warn "Errore nella lettura del file '$_': $@\n";
        return;
    }

    # Verifica se il testo è presente nel file
    if ($contenuto_file =~ /$testo_da_cercare/i) {
        print "Trovato \"$testo_da_cercare\" nel file: $File::Find::name\n";
   

        #$nome_file = "$File::Find::name";
        #print "\n NOME FILE /$nome_file"; 
        #close $@; 
        # Apri il file in lettura
        

 
        # open(my $fh, '<', $nome_file) or die "Impossibile aprire '$nome_file': $!";
       
     }

   
 #   while (my $riga = <$fh>) {
 #       # Dividi la riga usando la stringa cercata come delimitatore
 #       my @parti = split(/$stringa_cercata/, $riga);
 #       # 
 #       $contatore += 1;
 #      }
 #   print "Trovato \"$testo_da_cercare\" " \$contatore\" volte."; 


}, $cartella_da_cercare);

print "\nRicerca completata.\n"; 

