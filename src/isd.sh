#!/bin/bash

# GLOBAL VARS
_ARGCOUNT_NO_OPTS=1
_OPTSTRING="p:hvf"
_CPP_TEMPLATE_PATH="/home/kkafara/Templates/cpp_template.sh"
_LATEX_TEMPLATE_PATH="/home/kkafara/Templates/latex_template.sh"
_MAKEFILE_TEMPLATE_PATH="/home/kkafara/Templates/Makefile"
_PATH="$(pwd)"
# echo "$_PATH"
##################################################################################################
# RETURN VALS
_SUCCESS=0
# FNF - file not found
_CPPFNF=1
_LATEXFNF=2
_MAKEFILEFNF=3
_CPP_NOREADPERM=4
_LATEX_NOREADPERM=5
_MAKFILE_NOREADPERM=6
_INVALID_USER_PATH=7
_ARG_ERR=8
_MKDIR_ERR=9
_TOUCH_ERR=10
_COPY_ERR=11
##################################################################################################
# OPT FLAGS
_VERBOSE=0
_HELP=0
_USERSPECPATH=0
_FORCE=0
##################################################################################################
# functions
function PrintHelp() {
    printf "%s\n\n" "isd.sh - init spoj directory"
    printf "%s\n" "Usage:"
    printf "\t%s\n\n" "isd.sh [<options>] DIR_NAME"
    printf "%s\n" "Description:"
    printf "\t%s\n\t%s\n\n" "Creates in current directory (or in given directory, if specified with -p option) subdirectory" "named DIR_NAME with 3 template files inside. (main.cpp, DIR_NAME.tex, Makefile)"
    printf "%s\n" "Options:"
    printf "\t%s\n" "-p PATH -- directory to create spoj directory in"
    printf "\t%s\n" "-h -- print this help message and exit with code _SUCCESS (0)"
    printf "\t%s\n\t%s\n\n" "-v -- verbose mode" "-f -- skip not existing/readable files and don't stop at failed creation"
    printf "%s\n" "Return values:"
    printf "\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n\t%s\n" "0 - script execution succeded"\
             "1 - cpp template file at: $_CPP_TEMPLATE_PATH was not found"\
             "2 - latex template file at: $_LATEX_TEMPLATE_PATH was not found"\
             "3 - makefile template at: $_MAKEFILE_TEMPLATE_PATH was not found"\
             "4 - cpp template file at: $_CPP_TEMPLATE_PATH is not readable"\
             "5 - latex template file at: $_LATEX_TEMPLATE_PATH is not readable"\
             "6 - makefile file at $_MAKEFILE_TEMPLATE_PATH is not readable"\
             "7 - invalid user-specified path"\
             "8 - DIR_NAME arg was not given or too many args"\
             "9 - failed to create directory"\
             "10 - failed to create at least one of the files"\
             "11 - failed to copy at least one template"
    # TODO 
}   
##################################################################################################
# reacting to options
while getopts ${_OPTSTRING} opt;
do
    case $opt in
        "h") _HELP=1 
            PrintHelp 
            exit $_SUCCESS
            ;;
        "v") _VERBOSE=1 ;;
        "p") user_path="$OPTARG"
            _USERSPECPATH=1
            ;;
        "f") _FORCE=1 ;;
    esac
done
##################################################################################################
# check if paths are valid and if files are readable
if [[ ! -f $_CPP_TEMPLATE_PATH ]]; then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File not found: $_CPP_TEMPLATE_PATH"
    [[ $_FORCE -eq 1 ]] && exit $_CPPFNF
elif [[ ! -r $_CPP_TEMPLATE_PATH ]]; then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File not readable: $_CPP_TEMPLATE_PATH"
    [[ $_FORCE -eq 1 ]] && exit $_CPP_NOREADPERM
fi

if [[ ! -f $_LATEX_TEMPLATE_PATH ]]; then 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File not found: $_LATEX_TEMPLATE_PATH"
    [[ $_FORCE -eq 1 ]] && exit $_LATEXFNF
elif [[ ! -r $_LATEX_TEMPLATE_PATH ]]; then 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File not readable: $_LATEX_TEMPLATE_PATH"
    [[ $_FORCE -eq 1 ]] && exit $_LATEX_NOREADPERM
fi

if [[ ! -f $_MAKEFILE_TEMPLATE_PATH ]]; then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File not found: $_MAKEFILE_TEMPLATE_PATH"
    [[ $_FORCE -eq 1 ]] && exit $_MAKEFILEFNF
elif [[ ! -r $_MAKEFILE_TEMPLATE_PATH ]]; then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File not readable: $_MAKEFILE_TEMPLATE_PATH"
    [[ $_FORCE -eq 1 ]] && exit $_MAKFILE_NOREADPERM
fi

if (( $_USERSPECPATH == 1 )); then
    if [[ ! -d $user_path ]]; then 
        printf "%s\n" "Invalid user-specified path (must be existing directory)"
        exit $_INVALID_USER_PATH
    else
        _PATH="$user_path"
    fi
fi
##################################################################################################
# remove options from arg list
shift "$(( $OPTIND - 1 ))"
##################################################################################################
# check if positional argument was given 
if (( $# == $_ARGCOUNT_NO_OPTS )); then
    dir_name=$1
elif (( $# < $_ARGCOUNT_NO_OPTS )); then
    printf "%s\n" "DIR_NAME arg was not given"
    exit $_ARG_ERR
else 
    printf "%s\n" "Too many positional args" "Expected $_ARGCOUNT_NO_OPTS" "Received $#" "Arg list: "
    for arg in $*;
    do 
        printf "%s  " "$arg"
    done
    printf "\n"
fi
##################################################################################################
# create folder 
[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Making directory $_PATH/$dir_name"
mkdir "$_PATH/$dir_name"

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]]  && printf "%s\n" "Directory created succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to create directory!"
    exit $_MKDIR_ERR
fi
##################################################################################################
# creating cpp file

# first changing directory to new-created directory
cd "${_PATH}/${dir_name}"

[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Creating $_PATH/$dir_name/main.cpp"
touch main.cpp

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File created succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to create file"
    if (( $_FORCE == 1 )); then
        printf "%s\n" "Proceeding..."
    else
        exit $_TOUCH_ERR
    fi
fi
##################################################################################################
# creating .tex file

[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Creating $_PATH/$dir_name/$dir_name.tex"
touch "$dir_name.tex"

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File created succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to create file"
    if (( $_FORCE == 1 )); then
        printf "%s\n" "Proceeding..."
    else
        exit $_TOUCH_ERR
    fi
fi
##################################################################################################
# creating makefile

[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Creating $_PATH/$dir_name/Makefile"
touch "Makefile"

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "File created succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to create file"
    if (( $_FORCE == 1 )); then
        printf "%s\n" "Proceeding..."
    else
        exit $_TOUCH_ERR
    fi
fi
##################################################################################################
# Copying cpp template

[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Copying content of $_CPP_TEMPLATE_PATH to $_PATH/$dir_name/main.cpp"
echo "$($_CPP_TEMPLATE_PATH $dir_name)" > "$_PATH/$dir_name/main.cpp"

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Copied succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to copy"
    if (( $_FORCE == 1 )); then
        printf "%s\n" "Proceeding..."
    else
        exit $_COPY_ERR
    fi
fi
##################################################################################################
# Copying latex template

[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Copying content of $_LATEX_TEMPLATE_PATH to $_PATH/$dir_name/$dirname.tex"
echo "$($_LATEX_TEMPLATE_PATH $dir_name)" > "$_PATH/$dir_name/$dir_name.tex"

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Copied succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to copy"
    if (( $_FORCE == 1 )); then
        printf "%s\n" "Proceeding..."
    else
        exit $_COPY_ERR
    fi
fi
##################################################################################################
# Copying makefile

[[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Copying content of $_MAKEFILE_TEMPLATE_PATH to $_PATH/$dir_name/$dirname.tex"
cp "$_MAKEFILE_TEMPLATE_PATH" "$_PATH/$dir_name/Makefile"

if (( $? == 0 )); then
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Copied succesfuly"
else 
    [[ $_VERBOSE -eq 1 ]] && printf "%s\n" "Failed to copy"
    if (( $_FORCE == 1 )); then
        printf "%s\n" "Proceeding..."
    else
        exit $_COPY_ERR
    fi
fi
##################################################################################################
exit $_SUCCESS
##################################################################################################
