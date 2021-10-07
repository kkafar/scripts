#!/bin/bash

__ret_assert_err__=9

log() {
	[ "$1" -eq 0 ] && echo -e "$2"
}

log_and_exit() {
	echo -e "$1";
	exit "$2";
}

log_and_exit_opt() {
	echo -e "$1";
	if [[ ! -z "$3" ]]; then
		echo -e "$3";
	fi
	exit "$2";
}

# params:
#		1 -- path
#		2 -- message (optional)
assert_dir_exists() {
	if [[ ! -d "$1" ]]; then
		log_and_exit_opt "Assertion failed: assert_dir_exists: Directory $1 not found. Make sure that the directory exists." "${__ret_assert_err__}" "$2"
	fi
}

# params:
#		1 -- actual value
#		2 -- expected value
#		3 -- message (optional)
assert_equals() {
	if [[ "$1" -ne "$2" ]]; then
		log_and_exit_opt "Assertion failed: assert_equals. Received: $1. Expected: $2" "${__ret_assert_err__}" "$3"
	fi
}

# params:
#		1 -- first value
#		2 -- second value
# 	3 -- message (optional)
assert_not_equals() {
	if [[ "$1" -eq "$2" ]]; then
		log_and_exit_opt "Assertion failed: assert_not_equals. Received $1. Expected: not $2" "${__ret_assert_err__}" "$3"
	fi
}

# params:
#		1 -- variable value
#		2 -- message (optional)
assert_variable_defined() {
	if [[ ! -z "$1" ]]; then
		log_and_exit_opt "Assertion failed: variable does not exist" "${__ret_assert_err__}" "$2"
	fi
}

unset __ret_assert_err__
