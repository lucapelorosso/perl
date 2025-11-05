#!/bin/bash

# Script per sostituire | con ; nel file FiltratiNew.csv

fileOutput="Filtrati.csv"

echo "Nome File: $fileOutput"

#!/bin/bash

CURRENT_DIR=$(pwd)
echo "Sei in: $CURRENT_DIR"


./EliminaDoppioni.pl 20250918_0080_659.870.592_0030000646_000003470547.csv >> $fileOutput
perl -ni -e 'print unless /^\s*$/'  $fileOutput

