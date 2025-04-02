#!/usr/bin/env bash

read_lines_from_file() {
    echo "read_lines_from_file"
    # Read lines from a file
    local file="$1"
    local line

    while IFS= read -r line; do
        echo "$line"
    done < "$file"
}

read_lines_from_file_into_array() {
    echo "read_lines_from_file_into_array"

    # Read lines from a file into an array
    local -a lines
    mapfile -t lines < "$1"

    # Print the lines
    for line in "${lines[@]}"; do
        echo "$line"
    done
}

function_returns_multiline_string() {
    log_info "function_returns_multiline_string"
    # Return a multiline string
    echo "Line1
Line2
Line3"
}

read_lines_from_function_output_into_array() {
    echo "read_lines_from_function_output_into_array"
    # Read lines from a function output into an array
    local -a lines
    mapfile -t lines < <(function_returns_multiline_string)

    # Print the lines
    for line in "${lines[@]}"; do
        echo "$line"
    done
}

read_lines_from_string_variable_into_array() {
    echo "read_lines_from_string_variable_into_array"
    # Read lines from a string variable into an array
    local -a lines
    local string="Line1\nLine2\nLine3"
    mapfile -t lines < <(echo -e "$string")

    # Print the lines
    for line in "${lines[@]}"; do
        echo "$line"
    done

    mapfile -t lines <<< "$string"
    # Print the lines
    for line in "${lines[@]}"; do
        echo "$line"
    done

    local string2="Line4
Line5
Line6"

    mapfile -t lines <<< "$string2"
    # Print the lines
    for line in "${lines[@]}"; do
        echo "$line"
    done
}

mapfile_demo() {
    echo "mapfile_demo"
    read_lines_from_function_output_into_array
    read_lines_from_string_variable_into_array
}
