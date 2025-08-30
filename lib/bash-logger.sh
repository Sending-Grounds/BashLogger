# Library

# Bash Logger function takes log level and message as 
function log() {
  local log_level=${1:-INFO}
  local message=$2
  local timestamp=$(date +'%Y-%m-%d %H:%M:%S')

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
