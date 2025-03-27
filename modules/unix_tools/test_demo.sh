#!/usr/bin/env bash

# To see all options for Bash' test command, run:
# $ man test
#
# The single square brackets ([ ... ]) is an synonym of the test command. 
# Double square brackets ([[ ... ]]) mean that an extended Bash set of tests is used.
# These mainly have to do with regular expression matching, and glob matching (and
# extended glob matching if you have that set too).

# -z STRING - the length of STRING is zero

# The if command merely executes the command you give it, and then if that command 
# returns an exit code of 0, will run the if portion of the if statement. Otherwise,
# it will run the else portion (if that's present).

function string_length() {
    # implicit form of calling a test command (via square brackets):
    if [ -z $nonexistent_variable ]
    then 
        echo "nonexistent_variable has zero length"
    else
        echo "nonexistent_variable does not have zero length"
    fi

    empty_string=""
    if [ -z $empty_string ]
    then 
        echo "empty_string has zero length"
    else
        echo "empty_string does not have zero length"
    fi 

    name=$1
    if [ -z $name ]
    then 
        echo "name has zero length"
    else
        echo "name does not have zero length"
    fi 

    # another (explicit) form of calling a test command:
    if test -z $name
    then 
        echo "name has zero length"
    else
        echo "name does not have zero length"
    fi 
}

demo() {
    echo test -f \(or [-f ...]\) checks whether file exists and is regular file
    echo test -L \(or [-L ...]\) checks whether file exists and is symbolic link
    echo test -f required/persons.json

    regular_file=required/persons.json
    symlink_file=required/diff/dir1/symlink_file

    if test -f "$regular_file"; then
    echo "$regular_file" exists and is regular file.
    else
    echo "$regular_file" does not exist or is not a regular file.
    fi

    if test -L "$regular_file"; then
    echo "$regular_file" exists and is symlink file.
    else
    echo "$regular_file" does not exist or is not a symlink file.
    fi


    if test -f "$symlink_file"; then
    echo "$symlink_file" exists and is regular file.
    else
    echo "$symlink_file" does not exist or is not a regular file.
    fi


    if test -L "$symlink_file"; then
    echo "$symlink_file" exists and is symlink file.
    else
    echo "$symlink_file" does not exist or is not a symlink file.
    fi
}

function test_demo() {
    string_length 'Bojan'
}