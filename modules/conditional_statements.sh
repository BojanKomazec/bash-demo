#!/usr/bin/env bash

# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html#Bash-Conditional-Expressions
# -z = string has Zero length (is null)
# -n = string has Non-zero length (is not null) (opposite of -z; instead of ! -z test use -n)

test_is_string_null() {
    local string="$1"
    if [ -z "$string" ]; then
        echo "string is null."
    else
        echo "string is NOT null. Value: $string"
    fi

    # see: https://www.shellcheck.net/wiki/SC2236
    if [ ! -z "$string" ]; then
        echo "string is NOT null. Value: $string"
    else
        echo "string is null."
    fi

    if [ -n "$string" ]; then
        echo "string is NOT null. Value: $string"
    else
        echo "string is null."
    fi

    if [ "$string" ]; then
        echo "string is NOT null. Value: $string"
    else
        echo "string is null."
    fi
}

test_is_value_zero() {
    local value="$1"
    if [ "$value" -eq 0 ]; then
        echo "value is zero."
    else
        echo "value is NOT zero. Value: $value"
    fi

    # see: https://www.shellcheck.net/wiki/SC2236
    if [ ! "$value" -eq 0 ]; then
        echo "value is NOT zero. Value: $value"
    else
        echo "value is zero."
    fi

    if [ "$value" -ne 0 ]; then
        echo "value is NOT zero. Value: $value"
    else
        echo "value is zero."
    fi

    if [ "$value" ]; then
        echo "value is NOT zero. Value: $value"
    else
        echo "value is zero."
    fi
    if [ "$value" ]; then
        echo "value is NOT zero. Value: $value"
    else
        echo "value is zero."
    fi
}

conditional_statements_demo() {
    local unassigned_variable
    local empty_string_single_quoted=''
    local empty_string_double_quoted=""
    local non_empty_string="Hello, World!"

    test_is_string_null "$unassigned_variable"
    test_is_string_null "$empty_string_single_quoted"
    test_is_string_null "$empty_string_double_quoted"
    test_is_string_null "$non_empty_string"

    test_is_value_zero 2
}
