#!/usr/bin/env bash

echo_quoted_string() {
    echo "echo_quoted_string"
    # Print quoted string
    echo "Hello, World!"
}

echo_unquoted_string() {
    echo "echo_unquoted_string"
    # Print unquoted string
    echo Hello, World!
}

echo_quoted_string_with_variable() {
    echo "echo_quoted_string_with_variable"
    # Print quoted string with variable
    local name="World"
    echo "Hello, $name!"
}

echo_unquoted_string_with_variable() {
    echo "echo_unquoted_string_with_variable"
    # Print unquoted string with variable
    local name="World"
    echo Hello, $name!
}

echo_quoted_string_with_escape() {
    echo "echo_quoted_string_with_escape"
    # Print quoted string with escape
    echo "Hello, \"World\"!"
}

echo_unquoted_string_with_escape() {
    echo "echo_unquoted_string_with_escape"
    # Print unquoted string with escape
    echo Hello, \"World\"!
}

echo_quoted_string_with_variable_and_escape() {
    echo "echo_quoted_string_with_variable_and_escape"
    # Print quoted string with variable and escape
    local name="World"
    echo "Hello, \"$name\"!"
}

echo_unquoted_string_with_variable_and_escape() {
    echo "echo_unquoted_string_with_variable_and_escape"
    # Print unquoted string with variable and escape
    local name="World"
    echo Hello, \"$name\"!
}

echo_message_and_return_value_to_stdin() {
    echo "echo_message_and_return_value_to_stdin"
    # Print message and variable
    local name="$1"
    echo "Hello, $name!"
    return 123
}

# We need to use > /dev/stderr or >&2 to redirect the output to stderr
echo_message_to_stderr_and_return_value_to_stdin() {
    # echo "echo_message_to_stderr_and_return_value_to_stdin" > /dev/stderr
    echo "echo_message_to_stderr_and_return_value_to_stdin" >&2
    # Print message and variable
    local name="$1"
    echo "Hello, $name!"
    return 123
}

read_function_return_value() {
    echo "read_function_return_value"
    # Read function return value
    local message
    message=$(echo_message_and_return_value_to_stdin "Bojan")
    local return_value=$?
    echo "Return value: $return_value"

    # This message will contain undesired string "echo_message_and_return_value_to_stdin"
    echo "Message: $message"

    message=$(echo_message_to_stderr_and_return_value_to_stdin "Bojan")
    return_value=$?
    echo "Return value: $return_value"
    # This message will contain expected string
    echo "Message: $message"
}

echo_demo() {
    echo_quoted_string
    echo_unquoted_string
    echo_quoted_string_with_variable
    echo_unquoted_string_with_variable
    echo_quoted_string_with_escape
    echo_unquoted_string_with_escape
    echo_quoted_string_with_variable_and_escape
    echo_unquoted_string_with_variable_and_escape
    read_function_return_value
}
