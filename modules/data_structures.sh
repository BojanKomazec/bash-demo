#!/usr/bin/env bash

array_demo() {
    # Declare an array
    declare -a my_array

    # Initialize an array
    my_array=(1 2 3 4 5)

    # Access an element
    echo "Element at index 0: ${my_array[0]}"

    # Update an element
    my_array[0]=10
    echo "Element at index 0: ${my_array[0]}"

    # Print the entire array
    echo "All elements: ${my_array[@]}"

    # Print the length of the array
    echo "Array length: ${#my_array[@]}"

    # Iterate over the array
    for element in "${my_array[@]}"; do
        echo "Element: $element"
    done
}

array_demo2() {
    # Create an array from awk output
    names=($(grep -Po '"name": .*[^,]' ./required/$JSON_FILE | awk -F': ' '{gsub(/"/, "", $2);print $2}'))
    echo names array:
    echo ${names[0]} ${names[1]} ${names[2]}

    # Loop through every element in the array
    echo names array \(loop\):
    for i in "${names[@]}"
    do
    :
    echo $i
    done

    echo Printing array index and value:
    for i in "${!names[@]}"; do
    printf "%s\t%s\n" "$i" "${names[$i]}"
    done

    surnames=($(grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F': ' '{gsub(/"/, "", $2);print $2}'))

    echo Iterating over two arrays of same size:
    for i in "${!names[@]}"; do
    printf "%s %s\n" "${names[$i]}" "${surnames[$i]}"
    full_name="${names[$i]} ${surnames[$i]}"
    echo ${full_name}
    done

    # Find all files with specific extension and in specified directory and put their names in array.
    # ./required/ - sets working directory for find command
    # -printf '%f\n' - prints only file name (including extension)
    names2=($(find ./required/ -type f -path '*dummy_files*/*' -name '*.abc' -printf '%f\n'))
    echo Printing names2 array index and value:
    for i in "${!names2[@]}"; do
    printf "%s\t%s\n" "$i" "${names2[$i]}"
    done
}

associative_array_demo() {
    log_info "Associative array demo"

    # Declare an associative array
    declare -A my_assoc_array

    # Initialize an associative array
    my_assoc_array=(
        [name]="John"
        [age]=30
        [city]="New York"
    )

    # Add an element
    my_assoc_array[country]="USA"

    # Access an element
    echo "Name: ${my_assoc_array[name]}"
    echo "Country: ${my_assoc_array[country]}"
    echo "City: ${my_assoc_array[city]}"
    echo "Age: ${my_assoc_array[age]}"

    # Update an element
    echo && echo "Updating an element:"
    my_assoc_array[age]=32
    echo "Age: ${my_assoc_array[age]}"

    echo && echo "Iterate over the associative array:"
    # Print the entire associative array
    for key in "${!my_assoc_array[@]}"; do
        echo "$key: ${my_assoc_array[$key]}"
    done

    # Print the length of the associative array
    echo && echo "Associative array length: ${#my_assoc_array[@]}"
}

data_structures_demo() {
    log_info "Data structures demo"

    # array_demo
    # array_demo2
    associative_array_demo
}
