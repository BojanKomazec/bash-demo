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

log_trace() {
    if [[ "$VERBOSE" == true ]]; then
        # two spaces before the message are required as the emoji takes up two characters
        printf "%b\n" "🔍 $1" >&2;
    fi
}

log_debug() {
    if [[ "$VERBOSE" == true ]]; then
        # two spaces before the message are required as the emoji takes up two characters
        printf "%b\n" "🐛 $1" >&2;
    fi
}

# Sometimes we need to use echo instead of printf, e.g. when we want to pipe the output to another command:
# echo "$response" | jq .
log_info() {
    if [[ "$VERBOSE" == true ]]; then
        # two spaces before the message are required as the emoji takes up two characters
        printf "%b\n" "ℹ️  $1" >&2;
    fi
}

log_error() {
    printf "%b\n" "❌ $1" >&2;
}

log_error_and_exit() {
    printf "%b\n" "❌ $1" >&2; exit 1;
}

log_warning() {
    # two spaces before the message are required as the emoji takes up two characters
    printf "%b\n" "⚠️  $1" >&2;
}

log_fatal() {
    # two spaces before the message are required as the emoji takes up two characters
    printf "%b\n" "💀 $1" >&2;
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
