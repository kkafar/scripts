#!/bin/bash

if [[ -z ${SCRIPTS_DIR} ]]; then
	echo "SCRIPTS_DIR environment variable is not defined. 
	Follow these installation steps https://github.com/kkafar/scripts#installation"
	exit -1
fi

arg_count=2 # project-type, project-name

source ${SCRIPTS_DIR}/src/return-codes.sh
source ${SCRIPTS_DIR}/src/utils.sh

usage="Usage: $0 [OPTIONS] PROJECT_NAME PROJECT_TYPE\n
PROJECT_TYPE:\n
\tcpp\n
\tc\n
OPTIONS:\n
\t-h (print help message and exit)\n
\t-v (verbose mode)\n
\t-d DIR_PATH (directory to init project in; defaults to result of pwd)"

usage() { 
  echo -e ${usage}
}

info() {
  echo "Initializing $1 directory";
}

opt_str="t:hvd:"
while getopts ${opt_str} opt;
do
  case $opt in
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

assert_dir_exists "${project_parent_dir}"
assert_equals $# ${arg_count} "Invalid arg count. Expected: ${arg_count}"

project_name=$1
project_dir=${project_parent_dir}/${project_name}

source ${SCRIPTS_DIR}/src/templ-paths.sh

project_type=$2
case ${project_type} in
	"cpp")
		templ_dir=${__templ_cpp__}
		;;
	"c")
		templ_dir=${__templ_c__}
		;;
	*)
		log_and_exit "Invalid project type \"${project_type}\". See usage for valid ones." "${ret_invalid_arg}"
esac

assert_dir_exists "${templ_dir}"

log ${verbose} "Initializing project of name ${project_name} in ${project_parent_dir} directory."
 
if [[ ${verbose} -eq 0 ]]; then
	cp -rv ${templ_dir} ${project_dir}
else
	cp -r ${templ_dir} ${project_dir}
fi

exit ${ret_success};
