#!/bin/bash

templ_dir=${SCRIPTS_DIR}/templates/cpp-templ

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

log_and_exit_opt() {
	echo "$1";
	if [[ ! -z "$3" ]]; then
		echo "$3";
	fi
	exit "$2";
}

# params:
#		1 -- path
#		2 -- message (optional)
assert_dir_exists() {
	if [[ ! -d "$1" ]]; then
		log_and_exit_opt "Assertion failed: assert_dir_exists: Directory $1 not found. Make sure that the directory exists." "${ret_fnf}" "$2"
	fi
}

# params:
#		1 -- actual value
#		2 -- expected value
#		3 -- message (optional)
assert_equals() {
	if [[ "$1" -ne "$2" ]]; then
		log_and_exit_opt "Assertion failed: assert_equals. Received: $1. Expected: $2" "${ret_assert_err}" "$3"
	fi
}

# params:
#		1 -- first value
#		2 -- second value
# 	3 -- message (optional)
assert_not_equals() {
	if [[ "$1" -eq "$2" ]]; then
		log_and_exit_opt "Assertion failed: assert_not_equals. Received $1. Expected: not $2" "${ret_assert_err}" "$3"
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
assert_equals $# ${arg_count} "Invalid arg count. Expected: ${arg_count}"

project_name=$1
project_dir=${project_parent_dir}/${project_name}

log ${verbose} "Initializing project of name ${project_name} in ${project_parent_dir} directory."
 
if [[ ${verbose} -eq 0 ]]; then
	cp -rv ${templ_dir} ${project_dir}
else
	cp -r ${templ_dir} ${project_dir}
fi

exit ${ret_success};
