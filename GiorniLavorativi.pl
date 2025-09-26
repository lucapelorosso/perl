#!/usr/bin/perl
use strict;
use warnings;
use Date::Calc qw(Day_of_Week Add_Delta_Days Delta_Days);

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
            "$y-12-01" => 1,  # Pasqua
            "$y-12-02" => 1,  # Pasqua
        );

        # Festività mobili: Pasqua e Pasquetta
        #my ($e_y, $e_m, $e_d) = Easter_YMD($y);
        #$holidays{"$y-$e_m-$e_d"} = 1;  # Pasqua
        #my ($pm_y, $pm_m, $pm_d) = Add_Delta_Days($e_y, $e_m, $e_d, 1);
        #$holidays{"$pm_y-$pm_m-$pm_d"} = 1;  # Lunedì dell'Angelo (Pasquetta)

        # Conta solo giorni lun-ven che non sono festività
        $workdays++ if $dow < 6 && !exists $holidays{"$y-$m-$d"};

        # Passa al giorno successivo
        ($y, $m, $d) = Add_Delta_Days($y, $m, $d, 1);
    }

    return $workdays;
}

# --- Esempio di utilizzo ---
#my $giorni = giorni_lavorativi_italia("2025-09-26", "2025-10-05");
#print "Giorni lavorativi in Italia: $giorni\n";
