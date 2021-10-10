#!/bin/bash

###############################################################################
_TEMPLATE_PATH="/home/kkafara/Templates/latex_template_clear.tex"
###############################################################################
# OPCJE
_VERBOSE=0
_OPT_STRING="hv"
###############################################################################
# Zwracane wartości 
_SUCCESS=0
_NO_READ_PERM=1
_TEMPLATE_NOT_FOUND=2
_BAD_ARG_COUNT=3
_TOUCH_ERR=4
###############################################################################
function PrintHelp {
    echo -e -n "W bierzacym katalogu utworz plik FILE_NAME.tex (pierwszy i jedyny argument skryptu) wypełniony zawartością pliku $_TEMPLATE_PATH\n"
}
###############################################################################
# Obsługa opcji 
while getopts ${_OPT_STRING} opt; 
do
    case $opt in
        "h") PrintHelp
            exit $_SUCCESS
            ;;
        "v") _VERBOSE=1 ;;
    esac
done

shift "$(( $OPTIND - 1 ))"
###############################################################################
# Sprawdzenie czy szablon istnieje i użytkownik uruchamiający skrypt ma prawo odczytu
if [[ ! -f $_TEMPLATE_PATH ]]; then
    [[ $_VERBOSE -eq 1 ]] && echo "Nie odnaleziono pliku z szablonem. $_TEMPLATE_PATH"
    exit $_TEMPLATE_NOT_FOUND
elif [[ ! -r $_TEMPLATE_PATH ]]; then
    [[ $_VERBOSE -eq 1 ]] && echo "Brak uprawnień do odczytu pliku z szablonem. $_TEMPLATE_PATH"
    exit $_NO_READ_PERM
fi
###############################################################################
# Sprawdzenie liczby argumentów
if [[ $# -ne 1 ]]; then
    [[ $_VERBOSE -eq 1 ]] && echo "Nieprawidlowa liczba argumentow. Oczekiwano 1. Otrzymano $#"
    exit $_BAD_ARG_COUNT
fi
###############################################################################
# Kopiowanie pliku
cp "$_TEMPLATE_PATH" "$(pwd)/$1.tex"

if [[ $? -ne 0 ]]; then
    [[ $_VERBOSE -eq 1 ]] && echo "Kopiowanie nie powiodlo sie"
    exit $_TOUCH_ERR
else
    [[ $_VERBOSE -eq 1 ]] && echo "Kopiowanie zakonczone sukcesem"
fi
###############################################################################
exit $_SUCCESS
###############################################################################
