#!/usr/bin/env bash

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
        echo "🔍  $1" >&2;
    fi
}

log_debug() {
    if [[ "$VERBOSE" == true ]]; then
        # two spaces before the message are required as the emoji takes up two characters
        echo "🐛  $1" >&2;
    fi
}

log_info() {
    if [[ "$VERBOSE" == true ]]; then
        # two spaces before the message are required as the emoji takes up two characters
        echo "ℹ️  $1" >&2;
    fi
}

log_error() {
    echo "❌ $1" >&2;
}

log_error_and_exit() {
    echo "❌ $1" >&2; exit 1;
}

log_warning() {
    # two spaces before the message are required as the emoji takes up two characters
    echo "⚠️  $1" >&2;
}

log_fatal() {
    # two spaces before the message are required as the emoji takes up two characters
    echo "💀  $1" >&2;
}

#
# Custom log functions
#
log_success() {
    echo "✅ $1" >&2;
}

log_wait() {
    echo "⏳ $1" >&2;
}

log_start() {
    echo "🚀 $1" >&2;
}

log_skip() {
    echo "⏩ $1" >&2;
}

log_finish() {
    echo "🏁 $1" >&2;
}
