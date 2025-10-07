# Library
#======== ANSI Colors ========#
export RED="\e[0;31m"
export YELLOW="\e[0;33m"
export BLUE="\e[0;34m"
export RESET="\e[0m"

# Bash Logger function takes log level and message as 
function log() {
  local log_level=""
  local message=""
  local timestamp=""
  local lineno=""
  lineno="${BASH_LINENO[1]}"
  timestamp=$(date +'%Y-%m-%d %H:%M:%S')

  if [[ $# -eq 1 ]]; then
    printf "%s [DEBUG] No log level provided. Defaulting to INFO\n" "${timestamp}"
    log_level="INFO"
    message=${1} # Bash-ish to convert to quoted string
  else
    log_level=${1@U} # Bash-ish to convert to uppercase
    message=${2} # Bash-ish to convert to quoted string
  fi
  
  if [[ ${log_level} == "INFO" ]]; then
    printf "%s [L:%03d] [INFO] %s\n" "${timestamp}" "${lineno}" "${message}"
  elif [[ ${log_level} == "ERROR" ]]; then
    printf "%s [L:%03d] ${RED}[ERROR]${RESET} %s\n" "${timestamp}" "${lineno}" "${message}" >&2
  elif [[ ${log_level} == "WARN" ]]; then
    printf "%s [L:%03d] ${YELLOW}[WARN]${RESET} %s\n" "${timestamp}" "${lineno}" "${message}"
  elif [[ ${log_level} == "DEBUG" ]] && [[ ${DEBUG} == "True" ]]; then
    printf "%s [L:%03d] [DEBUG] %s\n" "${timestamp}" "${lineno}" "${message}" >&2
  elif [[ ${log_level} == "DEBUG" ]] && [[ ${DEBUG} != "True" ]]; then
    : # print nothing to avoid catching fatal
  elif [[ ${log_level} == "TRACE" ]] && [[ ${TRACE} == "True" ]]; then
    printf "%s [L:%03d] ${BLUE}[TRACE]${RESET} %s\n" "${timestamp}" "${lineno}" "${message}" >&2
  elif [[ ${log_level} == "TRACE" ]] && [[ ${TRACE} != "True" ]]; then
    : # print nothing to avoid catching fatal
  else
    printf "%s [FATAL] %s is not a valid option.\nValid options for the log() function are: TRACE, DEBUG, INFO, WARN, ERROR\n" "${timestamp}" "${log_level}"
    return 1
  fi
}

#--------- wrappers for log commands ---------# 
function log_trace(){
  local log_message=$1

  log "TRACE" "${log_message}"
}

function log_debug(){
  local log_message=$1

  log "DEBUG" "${log_message}"
}

function log_info(){
  local log_message=$1
  
  log "INFO" "${log_message}"
}

function log_warn(){
  local log_message=$1

  log "WARN" "${log_message}"
}

function log_error(){
  local log_message=$1

  log "ERROR" "${log_message}"
}
