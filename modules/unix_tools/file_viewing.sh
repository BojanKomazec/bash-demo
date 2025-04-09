#!/usr/bin/env bash

# File Viewing Tools

# These commands are used to view the contents of files.
# Examples:
# cat, less, more, head, tail, nl

#
head_demo() {
    # Display the first 10 lines of a file
    local file="$1"
    if [[ -f "$file" ]]; then
        head "$file"
    else
        log_error "File not found: $file"
    fi
}

tail_demo() {
    # Display the last 10 lines of a file
    local file="$1"
    if [[ -f "$file" ]]; then
        tail "$file"
    else
        log_error "File not found: $file"
    fi
}


