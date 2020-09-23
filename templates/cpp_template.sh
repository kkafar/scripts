#!/bin/bash

file_name="cpp_template.sh"

if (( $# == 1 )); then
    echo -e "/**\n * K. Kafara\n *\n * Kod zadania: $1\n * Link do strony zadania: https://pl.spoj.com/problems/$1/\n *\n */"
    echo -e "\n#include <iostream>\nusing namespace std;\n\nint main()\n{\n\n    return 0;\n}\n"
    exit 0
else
    echo -e "$file_name: NIEPRAWIDLOWA LICZBA ARGUMENTOW\n"
    exit 1
fi
