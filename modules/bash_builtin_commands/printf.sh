#!/usr/bin/env bash

printf_basic_demo() {
    # printf is a command that formats and prints data
    # It is similar to the C function printf
    # It can be used to format strings, numbers, and other data types

    # Basic usage
    printf "Hello, World!\n"

    # Formatting strings
    printf "Hello, %s!\n" "World"

    # Formatting numbers
    printf "The number is: %d\n" 42

    # Formatting floating point numbers
    printf "The number is: %.2f\n" 3.14159

    # Formatting multiple values
    printf "Name: %s, Age: %d\n" "Alice" 30

    # Using escape sequences
    printf "This is a tab:\tAnd this is a newline:\n"
}

printf_with_formatting() {
    # Using formatting options
    printf "Integer: %d\n" 42
    printf "Float: %.2f\n" 3.14159
    printf "String: %s\n" "Hello, World!"
    printf "Hexadecimal: %x\n" 255
    printf "Octal: %o\n" 255
}

printf_with_padding() {
    # Using padding and alignment
    printf "|%10s|\n" "Right"
    printf "|%-10s|\n" "Left"
    printf "|%10d|\n" 42
    printf "|%-10d|\n" 42
}

printf_with_precision() {
    # Using precision
    printf "%.2f\n" 3.14159
    printf "%.5s\n" "Hello, World!"
    printf "%10.2f\n" 3.14159
}

printf_with_escape() {
    # Using escape sequences
    printf "Hello, World!\n"
    printf "This is a tab:\tAnd this is a newline:\n"
    printf "This is a backslash: \\\n"
    printf "This is a single quote: '\n"
    printf "This is a double quote: \"\n"

    printf "Line1\nLine2"
    local string_with_escaped_chars="Hello\nWorld"
    printf "String with escaped characters: %s\n" "$string_with_escaped_chars"
    printf "String with escaped characters: %b\n" "$string_with_escaped_chars"

    printf "%b" "This is a string with escape sequences: \n\tHello, World!\n"
}

printf_with_variables() {
    # Using variables in printf
    local name="Alice"
    local age=30
    printf "Name: %s, Age: %d\n" "$name" "$age"

    # Using escape sequences with variables
    printf "Hello, %s!\n" "$name"
    printf "You are %d years old.\n" "$age"
}

printf_demo() {
    log_info "printf_demo()"

    # printf_basic_demo
    # printf_with_formatting
    # printf_with_padding
    # printf_with_precision
    printf_with_escape
    # printf_with_variables
}