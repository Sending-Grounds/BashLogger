# Library

# Bash Logger function takes log level and message as 
function log() {
  local log_level=""
  local message=""
  local timestamp=""
  timestamp=$(date +'%Y-%m-%d %H:%M:%S')

  if [[ $# -eq 1 ]]; then
    printf "%s [DEBUG] No log level provided. Defaulting to INFO\n" "${timestamp}"
    log_level="INFO"
    message=${1} # Bash-ish to convert to quoted string
  else
    log_level=${1@U} # Bash-ish to convert to uppercase
    message=${2} # Bash-ish to convert to quoted string
  fi
  
  if [[ ${log_level^^} == "INFO" ]]; then
    printf "%s [INFO] %s\n" "${timestamp}" "${message}"
  elif [[ ${log_level^^} == "ERROR" ]]; then
    printf "%s [ERROR] %s\n" "${timestamp}" "${message}" >&2
  elif [[ ${log_level^^} == "WARN" ]]; then
    printf "%s [WARN] %s\n" "${timestamp}" "${message}"
  elif [[ ${log_level^^} == "DEBUG" ]] && [[ ${DEBUG} == "True" ]]; then
    printf "%s [DEBUG] %s\n" "${timestamp}" "${message}" >&2
  elif [[ ${log_level^^} == "DEBUG" ]] && [[ ${DEBUG} != "True" ]]; then
    : # print nothing to avoid catching fatal
  elif [[ ${log_level^^}} == "TRACE" ]] && [[ ${TRACE} = "True" ]]; then
    printf "%s [TRACE] %s\n" "${timestamp}" "${message}" >&2
  elif [[ ${log_level^^} == "TRACE" ]] && [[ ${TRACE} != "True" ]]; then
    : # print nothing to avoid catching fatal
  else
    printf "%s [FATAL] %s is not a valid option.\nValid options for the log() function are: TRACE, DEBUG, INFO, WARN, ERROR\n" "${timestamp}" "${log_level}"
    return 1
  fi
}

# wrapper for log debug
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
