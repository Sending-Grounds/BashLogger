# BashLogger
This is an improved and more robust logger for Bash, to ensure that our scripts have just as a high quality logging as we get in other languages like Go, Python, etc...

The logger supports the following log-levels: TRACE, DEBUG, INFO, WARN, ERROR, and by default will log the date, log level and the message

## How To Use
Doing the following:
```
# Pull the library in 
source .bash-logger.sh

log_info "This is a test log statement. Currently in function: ${FUNCNAME[0]}"
```
Will result in us seeing:
```bash
2025-08-30 13:34:00 [INFO] This is a test log statement. Currently in function: test_log_function
```

## FAQ
**Work In Progress**

## Troubleshooting
**Work In Progress**
