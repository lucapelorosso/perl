#!/usr/bin/perl
use strict;
use warnings;
# Libreria per il calcolo delle date
use Date::Calc qw(Day_of_Week Add_Delta_Days Delta_Days);

# sb routine per calcolare giorni lavorativi tra due date: sabato e domenica non lavorativi, calcoliamo anche i giorni di festività nazionali italiani
sub giorni_lavorativi_italia {
    my ($start_date, $end_date) = @_;

    # Converti yyyy-mm-dd in anno, mese, giorno
    my ($start_year, $start_month, $start_day) = split /-/, $start_date;
    my ($end_year, $end_month, $end_day)     = split /-/, $end_date;

    my $total_days = Delta_Days($start_year, $start_month, $start_day,
                                $end_year, $end_month, $end_day);

    my $workdays = 0;
    my ($y, $m, $d) = ($start_year, $start_month, $start_day);

    for my $i (0..$total_days) {
        my $dow = Day_of_Week($y, $m, $d);  # 1 = lunedì, 7 = domenica

        # Festività fisse italiane
        my %holidays = (
            "$y-01-01" => 1,  # Capodanno
            "$y-01-06" => 1,  # Epifania
            "$y-04-25" => 1,  # Festa della Liberazione
            "$y-05-01" => 1,  # Festa dei Lavoratori
            "$y-06-02" => 1,  # Festa della Repubblica
            "$y-08-15" => 1,  # Ferragosto
            "$y-11-01" => 1,  # Tutti i Santi
            "$y-12-08" => 1,  # Immacolata Concezione
            "$y-12-25" => 1,  # Natale
            "$y-12-26" => 1,  # Santo Stefano
            "$y-04-20" => 1,  # Pasqua --> da modificare ogni anno
            "$y-04-25" => 1,  # Pasquetta --> da modificare ogni anno
        );
        # Conta solo giorni lun-ven che non sono festività
        $workdays++ if $dow < 6 && !exists $holidays{"$y-$m-$d"};

        # Passa al giorno successivo
        ($y, $m, $d) = Add_Delta_Days($y, $m, $d, 1);
    }

    return $workdays;
}

my $file = shift @ARGV or die "Uso: $0 <file>\n";

open my $fh, '<', $file or die "Non posso aprire $file: $!\n";

my $countAccettati = 0;
my $countConsegnati = 0;
my $countFouriSla = 0;
my $countMancaTracciatura = 0;
my $countInSla = 0;
my $giorniPoste = 5; 

my $DataAccettazione;
my $DataConsegna;

while (my $riga = <$fh>) {
   chomp $riga;   
   # my @campi = split /\|/, $_, -1;   # split sui |, conservando i vuoti
    my @campi = split /;/, $riga;   # dividi su uno o più spazi
    # esempio: controllo se il terzo campo (colonna 4) è valorizzato: data di accettazione;
    if (defined $campi[3] && $campi[3] ne '') {
       # print "Campo valorizzato nella riga: $_\n";
       $countAccettati = $countAccettati + 1;


       if ($campi[3] =~ /^(\d{2})(\d{2})(\d{4})$/) {
         my ($day, $month, $year) = ($1, $2, $3);
         $day = sprintf("%02d", $day);
         $month   = sprintf("%02d", $month);
         $DataAccettazione  = "$year-$month-$day";
         print "Data accettazione: $DataAccettazione \n";

       }
    }

    print "Data Accettazione A : $campi[3] \n";
    print "Data Consegna A: $campi[4] \n";

    # esempio: controllo se il terzo campo (colonna 5) è valorizzato: data di consegna;
    if (defined $campi[4] && $campi[4] ne '') {
       # print "Campo valorizzato nella riga: $_\n";
       $countConsegnati = $countConsegnati + 1;
      
       if ($campi[4] =~ /^(\d{2})(\d{2})(\d{4})$/) {
        
         my ($day, $month, $year) = ($1, $2, $3);
         $day = sprintf("%02d", $day);
         $month   = sprintf("%02d", $month);         
         $DataConsegna  = "$year-$month-$day";
         print "Data Consegna $campi[4] \n";
        }
        else { 
               $countMancaTracciatura = $countMancaTracciatura +1;
               print "Data Consegna non valorizzata \n";      
            }            
    }   
    # verifico che la data di accettazione e la data di consegna siano entrambe valorizzate
    if (defined $DataConsegna && $DataConsegna ne '' && defined $DataAccettazione && $DataAccettazione ne ''  ) {     

        # determino quanti sono i giorni lavorativi presenti tra la data di accettazione e la data di Consegna
        my $giorni = giorni_lavorativi_italia($DataAccettazione, $DataConsegna);
        # tolgo un giorno perchè devo calcolare dal giorno dopo l'accettazione;
        $giorni = $giorni -1;
        # print "Giorni lavorativi in Italia: $giorni\n";

        # conto se il delta di giorni tra il consegnato e l'accettazione supera i 5 giorni concordati con poste italiane
        if ($giorni > $giorniPoste) {
            $countFouriSla = $countFouriSla +1;
        }
    }     
}
$countInSla =  $countConsegnati - $countFouriSla;
print "Accettati: $countAccettati \n";
print "Consegnati:  $countConsegnati \n";
print "Manca Tracciatura: $countMancaTracciatura \n";
print "Consegnati in sla: $countInSla \n";
print "Consegnati fuori sla: $countFouriSla \n";
close $fh;
