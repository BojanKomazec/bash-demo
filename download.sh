#!/bin/sh
PARAMETER_FILE="./required/url_params.txt"
URL="https://api.openaq.org/v1/latest?"

# Internal Field Separator allows parsing each line of the file into the array element
IFS="
"

for param in $(cat "$PARAMETER_FILE")
do
    wget "${URL}${param}" >> "$OUTPUT_FILE"
done
