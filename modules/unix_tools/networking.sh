#!/usr/bin/env bash

# Networking Tools

source '../util/log.sh'

# echo "PATH (networking.sh): $PATH"
# echo "SHELL (networking.sh): $SHELL"
# echo "curl path (networking.sh): $(which curl)"

test_paths() {
    echo "PATH (test_paths): $PATH"
    echo "SHELL (test_paths): $SHELL"
    echo "curl path (test_paths): $(which curl)"
}

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
# curl "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m" 
# 
# Example response:
# {
#     "latitude": 51.5,
#     "longitude": -0.120000124,
#     "generationtime_ms": 0.038504600524902344,
#     "utc_offset_seconds": 0,
#     "timezone": "GMT",
#     "timezone_abbreviation": "GMT",
#     "elevation": 16,
#     "current_weather_units": {
#         "time": "iso8601",
#         "interval": "seconds",
#         "temperature": "°C",
#         "windspeed": "km/h",
#         "winddirection": "°",
#         "is_day": "",
#         "weathercode": "wmo code"
#     },
#     "current_weather": {
#         "time": "2025-04-08T16:30",
#         "interval": 900,
#         "temperature": 14.3,
#         "windspeed": 12.3,
#         "winddirection": 95,
#         "is_day": 1,
#         "weathercode": 3
#     }
# }
get_forecast_response_payload() {
    log_trace "get_forecast_response_payload()"

    local latitude="$1"
    local longitude="$2"

    # Declare an associative array
    declare -A params

    params=(
        [latitude]="$latitude"
        [longitude]="$longitude"
        [current_weather]=true
    )

    local DOMAIN="https://api.open-meteo.com"
    local API_VERSON="v1"
    local ENDPOINT="forecast"
    local ENDPOINT_PATH="/${API_VERSON}/${ENDPOINT}"
    local QUERY=""

    for key in "${!params[@]}"; do
        QUERY="${QUERY}${key}=${params[$key]}&"
    done

    # Remove the trailing '&' character
    QUERY="${QUERY%&}"

    local URL="${DOMAIN}${ENDPOINT_PATH}?${QUERY}"
    log_debug "URL: $URL"

    response=$(curl \
        -s \
        -w "\n%{http_code}" \
        -X GET \
        "$URL" \
        -H "Content-Type: application/json")

    # Extract the HTTP response code
    http_code=$(echo "$response" | tail -n 1)

    # Check if the request was successful
    if [[ "$http_code" -ne 200 ]]; then
        log_error "Error: Unable to fetch weather data. HTTP status code: $http_code"
        log_error "Response: $response"
        exit 1
    fi

    # Extract the JSON payload
    payload=$(echo "$response" | awk 'NR==1{print; exit}')

    # Check if payload is empty
    if [[ -z "$payload" ]]; then
        log_error "Error: Empty payload in response from the server."
        exit 1
    fi

    # Check if the response is valid JSON
    if ! echo "$payload" | jq empty; then
        log_error "Error: Invalid JSON response."
        log_error "Response: $payload"
        exit 1
    fi

    # # Check if the response contains the expected fields
    # if ! echo "$payload" | jq -e '.current_weather' > /dev/null; then
    #     echo "Error: Missing 'current_weather' field in the response."
    #     echo "Response: $payload"
    #     exit 1
    # fi

    # # Check if the response contains the expected fields
    # if ! echo "$payload" | jq -e '.current_weather.temperature' > /dev/null; then
    #     echo "Error: Missing 'temperature' field in the response."
    #     echo "Response: $payload"
    #     exit 1
    # fi

    # Don't use echo as echo adds a new line to the output by default.
    # We want to return the payload as it is.
    printf "%s" "$payload"
}

show_current_weather() {
    log_trace "show_current_weather()"

    # Fetch the current weather data for London
    local LATITUDE=51.5074
    local LONGITUDE=-0.1278

    # Fetch the current weather data
    local valid_json_payload
    if ! valid_json_payload=$(get_forecast_response_payload "$LATITUDE" "$LONGITUDE"); then
        echo "Error: Failed to fetch current weather data."
        exit 1
    fi

    current_weather=$(echo "$valid_json_payload" | jq -r '.current_weather')

    # Print the current weather
    echo "Current weather in London:"
    # echo "$current_weather" | jq -r '.temperature, .windspeed'
    echo "Temperature: $(echo "$current_weather" | jq -r '.temperature')°C"
    echo "Wind Speed: $(echo "$current_weather" | jq -r '.windspeed') km/h"
    echo "Weather data fetched successfully."
    echo
}

# curl_put_demo_1(){
#     # Edit the settings of the cluster
#     response=$(curl \
#         -s \
#         -u "$ES_USERNAME:$ES_PASSWORD" \
#         -X PUT \
#         "host/_cluster/settings" \
#         -H "Content-Type: application/json" \
#         -d \
#         "$request_body")
# }

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

networking_demo() {
    log_info "networking_demo()"
    # get_forecast_response_payload
    show_current_weather
    # wget_download_demo
}