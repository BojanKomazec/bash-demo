#!/usr/bin/env bash

print_all_vars(){
    # Print all variables
    echo "All variables:"
    declare -p
}

print_var(){
    # Print a specific variable
    local var_name="$1"
    echo "Variable $var_name:"
    declare -p "$var_name"
}

declare_array_demo(){
    # Declare an array
    declare -a fruits=("apple" "banana" "cherry")

    # Print the array elements
    echo "Fruits: ${fruits[@]}"
    # Expected output: Fruits: apple banana cherry
}

declare_string_demo(){
    # Declare a string variable
    declare -r greeting="Hello, World!"

    # Print the string
    echo $greeting
}

declare_integer_demo(){
    # Declare an integer variable
    declare -i number=42

    # Print the integer
    echo "The number is: $number"
}

redeclare_integer_demo(){
    log_info "redeclare_integer_demo"
    # Redeclare an integer variable
    declare -i number=100

    # Assign value of string to integer variable
    number="200"
    # Print the integer
    echo "The number is: $number"
}

declare_float_demo(){
    # Declare a float variable
    # declare -f number=3.14
    # declare: cannot use `-f' to make functions

    # Print the float
    echo "The float is: $number"
}

declare_boolean_demo(){
    # Declare a boolean variable
    # declare -b is_true=true
    # declare: -b: invalid option

    # Print the boolean
    echo "The boolean is: $is_true"
}

declare_variable_with_default_value_demo(){
    # Declare a variable with a default value
    declare -i number=${1:-10}

    # Print the number
    echo "The number is: $number"
}

declare_demo() {
    print_var "a"
    print_all_vars
    declare_integer_demo
    redeclare_integer_demo
    declare_array_demo
    declare_string_demo
    declare_float_demo
    declare_boolean_demo
    declare_variable_with_default_value_demo 1
}
