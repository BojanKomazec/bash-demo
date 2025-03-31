#!/usr/bin/env bash

string_types_demo() {
    local null_string=''
    local non_null_string="Hello, World!"
    local empty_string=""
    local non_empty_string="Hello, World!"
    local string_with_spaces="   "
    local string_with_tabs="		"
    local string_with_newline="Hello,\nWorld!"
    local string_with_special_chars="Hello, @#$%^&*()!"
    local string_with_escaped_chars="Hello, \"World\"!"
    local string_with_variable="Hello, $USER!"
    local string_with_variable_and_escape="Hello, \"$USER\"!"
    local string_with_variable_and_escape_quoted="Hello, \"$USER\"!"
}

substring_removal_demo() {
    echo
    echo 'substring_removal_demo()'
    echo

    echo '$PWD' = $PWD

    # ${string##substring} deletes longest match of substring from front of $string
    # substring may include a wildcard *, matching everything

    # This can be used to extract the name of the working directory from its full path:
    echo ${PWD##*/}


    # ${string#substring} - Deletes shortest match of substring from front of $string.
}

# Arguments:
# $1 = name
string_concatenation_demo() {
    echo 'string_concatenation_demo()'

    echo $#

    if [[ $# != 1 ]]
    then
        echo 'This function requires argument(s)'
        return 1
    fi

    echo Concatenating strings:
    a='Hello'
    b='world'
    d="${a}, ${b}!"
    echo ${d}

    # (!) Argument supstitution does not happen if string is under single quotes!
    message='Hello $1'
    echo $message
    # ouput: Hello $1

    message="Hello $1"
    echo $message
    # output: Hello Bojan
}

string_demo() {
    string_concatenation_demo 'Bojan'
}
