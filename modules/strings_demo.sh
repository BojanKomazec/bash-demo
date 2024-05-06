function substring_removal_demo() {
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
function string_concatenation_demo() {
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
    # Shell variables will not get expanded within single quotes.
    message='Hello $1'
    echo $message
    # ouput: Hello $1

    message="Hello $1"
    echo $message
    # output: Hello Bojan
}

function string_demo() {
    string_concatenation_demo 'Bojan'
}
