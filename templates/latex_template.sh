#!/bin/bash

file_name="latex_template.sh"

if (( $# == 1 )); then
    echo -n "% K. Kafara"
    echo -e -n "\n\documentclass[12pt]{article}\n\usepackage{polski}\n\usepackage[utf8]{inputenc}\n\usepackage{amsmath}\n\usepackage{amsthm} %"
    echo -n " \theoremstyle"
    echo -e -n "\n\usepackage{amssymb}\n\n"
    echo -n "\author{K. Kafara}"
    echo -e -n "\n"
    echo -n "\title{SPOJ\\\\$1\\\\PELNA_NAZWA}"
    echo -e -n "\n"
    echo -n "\date{}"
    echo -e -n "\n\n"
    echo -n "\theoremstyle{definition} \newtheorem{obserwacja}{Obs.}"
    echo -e -n "\n\n"
    echo -n "\begin{document}"
    echo -e -n "\n\maketitle\n"
    echo -n "\newpage"
    echo -e -n "\n\n\section{Problem}\n\n\section{Oznaczenia}\n\n\section{Obserwacje}\n\n\section{Rozwiązanie}\n\n\section{Złożoność}\n\n"
    echo -n "\end{document}"
    echo -e -n "\n"
    exit 0
else
    echo -e "$file_name: NIEPRAWIDLOWA LICZBA ARGUMENTOW\n"
    exit 1
fi





























