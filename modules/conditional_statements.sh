#!/usr/bin/env bash

# -z = string has Zero length (is null)


test_is_string_null() {
    local string="$1"
    if [ -z "$string" ]; then
        echo "string is null."
    else
        echo "string is NOT null. Value: $string"
    fi
}

string_checks_demo() {
    local unassigned_variable
    local empty_string_single_quoted=''
    local empty_string_double_quoted=""
    local non_empty_string="Hello, World!"

    test_is_string_null "$unassigned_variable"
    test_is_string_null "$empty_string_single_quoted"
    test_is_string_null "$empty_string_double_quoted"
    test_is_string_null "$non_empty_string"
}