#!/usr/bin/env bash

# printf is more portable than echo. 
# printf by default interprets escape sequences, while echo does not (echo needs to be called with -e for that).
# printf by default does not add a newline at the end, while echo does.

#
# Logging functions
#
# Log Level hierarchy:
# 1. Trace
# 2. Debug
# 3. Info
# 4. Warning
# 5. Error
# 6. Fatal

# Apart from icons, it's good to have names of log levels in the log messages. This is helpful for filtering logs in log management systems.
# For example, in Kibana, you can filter logs by the message field. If you have a log message like "INFO: This is an info message", you can filter it with "message:INFO".
# This is useful for debugging and troubleshooting.
#
# two spaces before the message are required as the emoji takes up two characters
#
# Sometimes we need to use echo instead of printf, e.g. when we want to pipe the output to another command:
# echo "$response" | jq .
log_trace() {
    if [[ "$VERBOSE" == true ]]; then
        printf "%b\n" "🔍 TRACE: $1" >&2;
    fi
}

log_debug() {
    if [[ "$VERBOSE" == true ]]; then
        printf "%b\n" "🐛 DEBUG: $1" >&2;
    fi
}

log_info() {
    if [[ "$VERBOSE" == true ]]; then
        printf "%b\n" "ℹ️  INFO: $1" >&2;
    fi
}

log_error() {
    printf "%b\n" "❌ ERROR: $1" >&2;
}

log_error_and_exit() {
    printf "%b\n" "❌ ERROR: $1" >&2; exit 1;
}

log_warning() {
    printf "%b\n" "⚠️  WARNING: $1" >&2;
}

log_fatal() {
    printf "%b\n" "💀 FATAL: $1" >&2;
}

#
# Custom log functions
#

log_success() {
    printf "%b\n" "✅ $1" >&2;
}

log_wait() {
    printf "%b\n" "⏳ $1" >&2;
}

log_start() {
    printf "%b\n" "🚀 $1" >&2;
}

log_skip() {
    printf "%b\n" "⏩ $1" >&2;
}

log_finish() {
    printf "%b\n" "🏁 $1" >&2;
}

log_prompt() {
    printf "%b\n" "❓ $1" >&2;
}

log_empty_line() {
    printf "\n" >&2;
}

log_directory() {
    printf "%b\n" "📂 $1" >&2;
}

log_file() {
    printf "%b\n" "📄 $1" >&2;
}

# Log array elements with their index
# Usage:
#   log_array_elements "true" "one" "two" "three"
#
#   print_index=true
#   array_numbers=("one" "two" "three")
#   log_array_elements "$print_index" "${array_numbers[@]}"
log_array_elements() {
     # First argument is the boolean
    local print_index="$1"

    # Remove the first argument
    shift

    # Remaining arguments are the array elements
    local array=("$@")

    if [[ "$print_index" == true ]]; then
        local index=0
        for element in "${array[@]}"; do
            printf "[%d] %b\n" "$index" "$element" >&2;
            ((index++))
        done
    else
        for element in "${array[@]}"; do
            printf "%b\n" "$element" >&2;
        done
    fi
}

log_json_pretty_print() {
    local json="$1"
    printf "%b\n" "$json" | jq . >&2;
}

log_string() {
    local string="$1"
    printf "%b\n" "$string" >&2;
}
