#!/bin/bash

# Script per sostituire | con ; nel file FiltratiNew.csv

fileOutput="Filtrati.csv"
fileInput=$1
echo "Nome File Input: $fileInput"
echo "Nome File Output: $fileOutput"

CURRENT_DIR=$(pwd)
echo "Sei in: $CURRENT_DIR"


./EliminaDoppioni.pl  $fileInput >> $fileOutput
#./EliminaDoppioni.pl 20250719_0080_659.870.592_0030000646_000003470445.csv >> $fileOutput
perl -ni -e 'print unless /^\s*$/'  $fileOutput

