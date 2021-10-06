RET_SUCCESS=0

usage() {
	echo "Usage: $0"
}

OPT_STRING="h"

while getopts ${OPT_STRING} opts;
do
  case $opts in
    "h") 
      usage
      exit ${RET_SUCCESS}
      ;;
  esac
done

shift "$(( $OPTIND - 1 ))"

# if [[ (! -d $HOME) && (-z ${HOME_DIR}) ]]; then
# 	echo "HOME env. variable must be defined or "
