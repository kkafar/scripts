#!/bin/bash

# TEMPLATES
TEMP_MAKEFILE_PATH=${TEMPLATES_PATH}/makefile-c
TEMP_CFILE_PATH=${TEMPLATES_PATH}/main.c

# RETURN CODES 
RET_SUCCESS=0
RET_TEMP_FILE_NOT_FOUND=1
RET_BAD_ARG_COUNT=2

# OPTIONS
OPT_STRING="hvd:"

ARG_COUNT=1

usage() { 
  echo "Usage: $0 [-h (prints this help message)] [-v (verbose mode)] [-d <path> (directory to init)] <project name>"; 
  exit ${RET_SUCCESS}; 
}

# 
info() {
  echo "Initializing $1 directory";
}

while getopts ${OPT_STRING} opts;
do
  case $opts in
    "h") 
      usage
      exit ${RET_SUCCESS}
      ;;
    "v")
      VERBOSE=0
      ;;
    "d")
      DIRECTORY=${OPTARG}
      ;;
  esac
done

shift "$(( $OPTIND - 1 ))"

VERBOSE=${VERBOSE:=1}
DIRECTORY=${DIRECTORY:=$(pwd)}

if [[ ! -f ${TEMP_MAKEFILE_PATH} ]]; then
  echo "File ${TEMP_MAKEFILE_PATH} not found. Ensure that correct path is provided in script source."
  exit ${RET_TEMP_FILE_NOT_FOUND}
elif [[ ! -f ${TEMP_CFILE_PATH} ]]; then
  echo "File ${TEMP_CFILE_PATH} not found. Ensure that correct path is provided in script source."
  exit ${RET_TEMP_FILE_NOT_FOUND}
fi

if [[ ! -d ${DIRECTORY} ]]; then
  echo "Directory ${DIRECTORY} not found. Ensure that the directory exists."
  exit ${RET_TEMP_FILE_NOT_FOUND}
fi

if [[ $# -ne ${ARG_COUNT} ]]; then
  echo "Invalid arg count. Expected: ${ARG_COUNT}."
  usage
  exit ${RET_BAD_ARG_COUNT}
fi

PROJECT_NAME=$1
PROJECT_DIR=${DIRECTORY}/${PROJECT_NAME}

[ ${VERBOSE} -eq 0 ] && info ${DIRECTORY}
 
[ ${VERBOSE} -eq 0 ] && echo "Creating ${DIRECTORY}/${PROJECT_NAME} directory"
mkdir ${PROJECT_DIR}

[ ${VERBOSE} -eq 0 ]  && echo "Creating project structure..."

[ ${VERBOSE} -eq 0 ]  && echo -e "\tCreate src dir"
mkdir ${PROJECT_DIR}/src

[ ${VERBOSE} -eq 0 ]  && echo -e "\tCreate build/{bin,obj} dirs"
mkdir -p ${PROJECT_DIR}/build/{bin,obj}

[ ${VERBOSE} -eq 0 ]  && echo -e "\tCreate main.c file"
cp ${TEMP_CFILE_PATH} ${PROJECT_DIR}/src/main.c

[ ${VERBOSE} -eq 0 ]  && echo -e "\tCreate makefile"
cp ${TEMP_MAKEFILE_PATH} ${PROJECT_DIR}/makefile

exit ${RET_SUCCESS};
