#!/bin/bash

templ_dir=${SCRIPTS_DIR}/templates/cpp-templ

# RETURN CODES 
ret_success=0
ret_fnf=1
ret_bad_arg_count=2
ret_assert_err=3
ret_env_err=4

if [[ -z ${SCRIPTS_DIR} ]]; then
	echo "SCRIPTS_DIR environment variable is not define. 
	Follow these installation steps https://github.com/kkafar/scripts#installation"
	exit ${ret_env_err}
fi

# OPTIONS
opt_str="hvd:"

arg_count=1

source ${SCRIPTS_DIR}/src/utils.sh

usage() { 
  echo "Usage: $0 [-h (prints this help message)] [-v (verbose mode)] [-d <path> (parent directory of new project)] <project name>";
  exit ${ret_success}; 
}

# 
info() {
  echo "Initializing $1 directory";
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
