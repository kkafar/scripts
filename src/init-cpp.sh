#!/bin/bash

if [[ -z ${SCRIPTS_DIR} ]]; then
	echo "SCRIPTS_DIR environment variable is not defined. 
	Follow these installation steps https://github.com/kkafar/scripts#installation"
	exit -1
fi

templ_dir=${SCRIPTS_DIR}/templates/cpp-templ
arg_count=1

source ${SCRIPTS_DIR}/src/return-codes.sh
source ${SCRIPTS_DIR}/src/utils.sh

usage() { 
  echo "Usage: $0 [-h (prints this help message)] [-v (verbose mode)] [-d <path> (parent directory of new project)] <project name>";
}

info() {
  echo "Initializing $1 directory";
}

opt_str="hvd:"
while getopts ${opt_str} opts;
do
  case $opts in
    "h") 
      usage
			echo ${ret_success}
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
