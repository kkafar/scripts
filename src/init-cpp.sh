#!/bin/bash

templ_dir=${TEMPLATES_PATH}/cpp-templ

# RETURN CODES 
ret_success=0
ret_fnf=1
ret_bad_arg_count=2
ret_assert_err=3

# OPTIONS
opt_str="hvd:"

arg_count=1

usage() { 
  echo "Usage: $0 [-h (prints this help message)] [-v (verbose mode)] [-d <path> (parent directory of new project)] <project name>";
  exit ${ret_success}; 
}

# 
info() {
  echo "Initializing $1 directory";
}

log() {
	[ "$1" -eq 0 ] && echo "$2"
}

log_and_exit() {
	echo "$1";
	exit "$2";
}

assert_dir_exists() {
	if [[ ! -d "$1" ]]; then
		log_and_exit "Directory $1 not found. Make sure that the directory exists." "${ret_fnf}"
	fi
}

assert_equals() {
	if [[ "$1" -ne "$2" ]]; then
		log_and_exit "Assertion failed. Received: $1. Expected: $2" "${ret_assert_err}"
	fi
}

while getopts ${opt_str} opts;
do
  case $opts in
    "h") 
      usage
      exit ${ret_success}
      ;;
    "v")
      verbose=0
      ;;
    "d")
      project_parent_dir=${OPTARG}
      ;;
  esac
done

shift "$(( $OPTIND - 1 ))"

verbose=${verbose:=1}
project_parent_dir=${project_parent_dir:=$(pwd)}

assert_dir_exists "${templ_dir}"
assert_dir_exists "${project_parent_dir}"

if [[ $# -ne ${arg_count} ]]; then
  echo "Invalid arg count. Expected: ${arg_count}."
  usage
  exit ${ret_bad_arg_count}
fi

project_name=$1
project_dir=${project_parent_dir}/${project_name}

log ${verbose} "Initializing project of name ${project_name} in ${project_parent_dir} directory."
 
log ${verbose} "Creating ${project_parent_dir}/${project_name} directory"
mkdir ${project_dir}

log ${verbose} "Creating project structure..."
[ ${verbose} -eq 0 ]  && echo "Creating project structure..."

[ ${verbose} -eq 0 ]  && echo -e "\tCreate src dir"
mkdir ${project_dir}/src

[ ${verbose} -eq 0 ]  && echo -e "\tCreate build/{bin,obj} dirs"
mkdir -p ${project_dir}/build/{bin,obj}

[ ${verbose} -eq 0 ]  && echo -e "\tCreate main.cpp file"
cp ${TEMP_CFILE_PATH} ${project_dir}/src/main.cpp

[ ${verbose} -eq 0 ]  && echo -e "\tCreate makefile"
cp ${TEMP_MAKEFILE_PATH} ${project_dir}/makefile

exit ${ret_success};
