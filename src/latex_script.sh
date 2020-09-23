#!/bin/bash

source_path="/home/kkafara/workspace/scripts/templates/latex_template.txt"

if (($# != 1)); then
    echo "Nieprawidlowa liczba argumentow. Przekazano $#, oczekiwano 1."
    echo "Lista przekazanych argumentow:"
    i=1
    for arg in $@
    do
        echo "$i. $arg"
        i=$((i + 1))
    done
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo "Przekazany argument $1 nie jest plikiem regularnym!"
    exit 2
fi

echo "Kopiuje zawartosc"
echo "$source_path"
echo "do"
echo "$(pwd)/$1"

cat $source_path > $(pwd)/$1

if (($? == 0)); then
    echo "Kopiowanie zakonczone sukcesem"
    exit 0
else
    echo "Kopiowanie zakonczone niepowodzeniem"
    exit 3
fi


