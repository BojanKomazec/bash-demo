#!/usr/bin/env bash

# Text Processing Tools

# These commands are used to process and manipulate text files, such as searching, filtering, transforming, and formatting text.
# Examples:
# grep, awk, sed, cut, sort, uniq, tr, wc, head, tail

json_parsing_with_grep(){
    JSON_FILE=persons.json

    echo "grep -Po '\"name\": .*' ./required/\$JSON_FILE"
    grep -Po '"name": .*' ./required/$JSON_FILE

    echo
    echo "grep -Po '\"name\": .*' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
    grep -Po '"name": .*' ./required/$JSON_FILE | awk -F':' '{print $2}'

    echo
    echo "grep -Po '\"name\": .*?[^\\]\",?' ./required/\$JSON_FILE"
    grep -Po '"name": .*?[^\\]",?' ./required/$JSON_FILE

    echo
    echo "grep -Po '\"name\": .*?[^\\]\"' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
    grep -Po '"name": .*?[^\\]"' ./required/$JSON_FILE | awk -F':' '{print $2}'

    echo
    echo "grep -Po '\"name\": .*[^,]' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
    grep -Po '"name": .*[^,]' ./required/$JSON_FILE | awk -F':' '{print $2}'

    echo
    echo "grep -Po '\"surname\": .*[^,]' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
    grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F':' '{print $2}'

    echo
    echo Without quotes:
    # gsub is used to remove quotes
    echo "grep -Po '\"surname\": .*[^,]' ./required/\$JSON_FILE | awk -F':' '{print \$2}'"
    grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F':' '{gsub(/"/, "", $2);print $2}'

    echo
    echo Without quotes and space at the beginning:
    # ': ' is used as separator instead of ':'
    echo "grep -Po '\"surname\": .*[^,]' ./required/\$JSON_FILE | awk -F': ' '{print \$2}'"
    grep -Po '"surname": .*[^,]' ./required/$JSON_FILE | awk -F': ' '{gsub(/"/, "", $2);print $2}'
}
