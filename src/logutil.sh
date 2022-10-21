
LOG_LEVEL_INFO="INFO"
LOG_LEVEL_WARN="WARN"
LOG_LEVEL_ERR="ERROR"

# Params: LOG_LEVEL LOG_MESSAGE [FILE] [FILE_MAX_LOG_LINES]
# Note that FILE_MAX_LOG_LINES might be provided iff FILE was provided.
log() {
	if [[ $# -ge 3 ]]; then
		if [[ $# -eq 4 ]] && [[ "$(wc -l < $3)" -gt $4 ]]; then
			echo "[$(date +%d-%m-%y/%H:%M:%S) $1] $2" > $3
		else
			echo "[$(date +%d-%m-%y/%H:%M:%S) $1] $2" >> $3
		fi
	else
			echo "[$(date +%d-%m-%y/%H:%M:%S) $1] $2"
	fi
}

# Params: LOG_MESSAGE [FILE] [FILE_MAX_LOG_LINES]
# Note that FILE_MAX_LOG_LINES might be provided iff FILE was provided.
log_info() {
	log ${LOG_LEVEL_INFO} "$@"
}
log_warn() {
	log ${LOG_LEVEL_WARN} "$@"
}
log_err() {
	log ${LOG_LEVEL_ERR} "$@"
}
