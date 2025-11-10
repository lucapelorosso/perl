#!/bin/bash

file="Filtrati.csv"

echo "Nome File: $file"

#!/bin/bash

CURRENT_DIR=$(pwd)
echo "Sei in: $CURRENT_DIR"


perl -pi.bak -e 's/\|/;/g' $file 

./ContaLavorazioni.pl $file
#./ContaLavorazioni.pl Filtrati.csv
