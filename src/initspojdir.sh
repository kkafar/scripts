#!/bin/bash

arg_count=1
cpp_templ_path="/home/kkafara/Templates/cpp_template.sh"
latex_templ_path="/home/kkafara/Templates/latex_template.sh"
makefile_templ_path="/home/kkafara/Templates/Makefile"
touch_flag=0

# return values
file_not_found=1
read_err=2
bad_arg_count=3
create_err=4
# if 


# Sprawdzamy czy liczba argumentow jest odpowiednia
if (( $# != $arg_count )); then
    echo "Nieprawidlowa liczba argumentow"
    echo "Oczekiwano $arg_count"
    echo "Otrzymano $#, lista:"
    i=1
    for arg in $@
    do
        echo "$i  $arg"
        i=$((i + 1))
    done
    exit $bad_arg_count
fi

# if [[ -f $1 ]]; then
    # echo "$1 nie jest plikiem regularnym"
    # exit 4
# fi

if [[ ! -f $cpp_templ_path ]]; then
    echo "Nie odnaleziono pliku $cpp_templ_path"
    exit $file_not_found
elif [[ ! -r $cpp_templ_path ]]; then
    echo "Nie mozna odczytac zawartosci pliku $cpp_templ_path"
    exit $read_err 
fi

if [[ ! -f $latex_templ_path ]]; then
    echo "Nie odnaleziono pliku $latex_templ_path"
    exit $file_not_found
elif [[ ! -r $latex_templ_path ]]; then
    echo "Nie mozna odczytac zawartosci pliku $latex_templ_path"
    exit $read_err 
fi


echo -e "\nTworze katalog $(pwd)/$1"
mkdir $(pwd)/$1

if (( $? != 0 )); then
    echo "Nie udalo sie utworzyc katalogu w $(pwd)/$1"
    exit $create_err
else 
    echo "Utworzono katalog $(pwd)/$1"
fi

# Zmiana bieżącego folderu
cd $1

echo -e "\nTworze plik $(pwd)/main.cpp"
touch main.cpp

if (( $? != 0 )); then
    echo "Nie udalo sie utworzyc pliku $(pwd)/main.cpp"
    touch_flag=1
else
    echo "Utworzono plik $(pwd)/main.cpp"
    echo -e "\nKopiuje zawartosc $cpp_templ_path do $(pwd)/main.cpp"
    # cat $cpp_templ_path > $(pwd)/main.cpp
    echo "$($cpp_templ_path $1)" > $(pwd)/main.cpp
    if (( $? != 0 )); then
        echo "Kopiowanie zakonczone niepowodzeniem"
    else
        echo "Kopiowanie zakonczone powodzeniem"
    fi
fi

echo -e "\nTworze plik $(pwd)/$1/$1.tex"
touch $1.tex

if (( $? != 0 )); then 
    echo "Nie udalo sie utworzyc pliku $(pwd)/$1.tex"
    touch_flag=1
else
    echo "Utworzono plik $(pwd)/$1.tex"
    echo -e "\nKopiuje zawartosc $latex_templ_path do $(pwd)/$1.tex"
    # cat $latex_templ_path > $(pwd)/$1.tex
    echo "$($latex_templ_path $1)" > $(pwd)/$1.tex
    if (( $? != 0 )); then
        echo "Kopiowanie zakonczone niepowodzeniem"
    else
        echo "Kopiowanie zakonczone powodzeniem"
    fi 
fi

echo -e "\nTworze plik $(pwd)/Makefile"
touch Makefile

if (( $? != 0 )); then
    echo "Nie udalo sie utworzyc pliku $(pwd)/Makefile"
    $touch_flag=1
else
    echo "Utworzono plik $(pwd)/Makefile"
    echo -e "\nKopiuje zawartosc $makefile_templ_path do $(pwd)/Makefile"
    cat $makefile_templ_path > $(pwd)/Makefile
    if (( $? != 0 )); then
        echo "Kopiowanie zakonczone niepowodzeniem"
    else
        echo "Kopiowanie zakonczone powodzeniem"
    fi 
fi

exit $touch_flag
