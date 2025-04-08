#!/usr/bin/env bash

# Desired output is a Hello string sent to stdout by the last echo command.
function_returns_string_via_echo() {

    # WARNING:
    # The following is a consequence of buffering in the shell - when this function
    # is called as $(function arg1 arg2).
    # 
    # If this echo sends output to stdout, it will be captured by the caller.
    # If this echo sends output to stderr, it will not be captured by the caller.
    # That's why we use `>&2` to send output to stderr.
    #
    # Redirect the output to stderr to enforce flush as otherwise
    # this string will also be returned by the function
    echo "function_returns_string_via_echo" >&2

    # Print message and variable
    local name="$1"
    echo "Hello, $name!"
}

function_returns_string_via_printf() {
    echo "function_returns_string_via_printf" >&2

    local name="$1"
    printf "Hello, %s!" "$name"
}

function_local_variables_demo() {
    echo "function_local_variables_demo"

    # Local variable
    local local_var="I am a local variable"
    echo "$local_var"

    # Global variable
    global_var="I am a global variable"
    echo "$global_var"

    # Function to demonstrate local and global variables
    function_with_local_variable() {
        local local_var="I am a local variable inside the function"
        echo "$local_var"
    }

    function_with_local_variable

    # This will print the global variable
    echo "$global_var"

    # This will print an empty line because local_var is not accessible here
    echo "$local_var"
    
    # It is possible to declare multiple local variables in one line
    # https://www.shellcheck.net/wiki/SC2155
    local a b c 
    a=1
    b=2
    c=3
    echo "a: $a, b: $b, c: $c"
}

reading_function_output_demo() {
    echo "reading_function_output_demo"

    # see: https://www.shellcheck.net/wiki/SC2155
    local ret_val

    # Wrong way:
    # https://www.shellcheck.net/wiki/SC2181
    ret_val=$(function_returns_string_via_echo "World")
    if [[ $? -eq 0 ]]; then
        echo "Return value: $ret_val"
    else
        echo "Error: function failed"
    fi

    # Correct way:
    if ret_val=$(function_returns_string_via_echo "World"); then
        echo "Return value: $ret_val"
    else
        echo "Error: function failed"
    fi

    if ret_val=$(function_returns_string_via_printf "World"); then
        echo "Return value: $ret_val"
    else
        echo "Error: function failed"
    fi
}

functions_demo() {
    echo "functions_demo"

    function_local_variables_demo
    reading_function_output_demo
}
