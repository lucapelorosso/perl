#!/bin/bash

# Script per sostituire | con ; nel file FiltratiNew.csv

file="Filtrati.csv"

echo "Nome File: $file"

perl -pi.bak -e 's/\|/;/g' $file 

./ContaLavorazioni.pl Filtrati.csv
