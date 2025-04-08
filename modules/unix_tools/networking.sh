#!/usr/bin/env bash

# Networking Tools

# These commands are used for network-related tasks, such as checking connectivity, transferring files, and debugging network issues.
# Examples:
# ping, curl, wget, scp, rsync, netstat, ssh

        # const response = await axios.get("https://api.open-meteo.com/v1/forecast", {
        # params: {
        #     latitude: 51.5074, // London
        #     longitude: -0.1278,
        #     current_weather: true
        # }



# - w "HTTP response code: %{http_code}\n" \
show_current_weather() {

    local params -A 
    # Create the request body
    local request_body="
    {
        \"$settings_type\": {
            \"$setting\": \"$setting_value\"
        }
    }"

    # Print request body
    echo "Request body: $request_body"

    echo && echo "Sending request to edit cluster settings..."

    local host="https://api.open-meteo.com/v1/forecast"

    # Edit the settings of the cluster
    response=$(curl \
        -s \
        -u "$ES_USERNAME:$ES_PASSWORD" \
        -X PUT \
        "host/_cluster/settings" \
        -H "Content-Type: application/json" \
        -d \
        "$request_body")    

}

wget_download_demo(){
    PARAMETER_FILE="./required/url_params.txt"
    URL="https://api.openaq.org/v1/latest?"

    # Internal Field Separator allows parsing each line of the file into the array element
    IFS="
    "

    for param in $(cat "$PARAMETER_FILE")
    do
        wget "${URL}${param}" >> "$OUTPUT_FILE"
    done
}
