#!/usr/bin/env bash

source "./modules/util/log.sh"


# read -p sends prompt to stderr, so we need to redirect printf to stderr as well.
# This follows the good practice of all user-facing messages being sent to stderr.
# This is important for scripts that may be used in pipelines or redirected to files.
# This way, the output of the script can be easily separated from user prompts.
prompt_user_for_confirmation() {
    local message="$1"
    local default_answer="$2"
    local confirmed=false

    while true;
    do
        printf "%b (y/n) [default: %s]: " "$message" "$default_answer" >&2
        read -e -r answer
        case $answer in
            [Yy] ) 
                confirmed=true
                break;;
            [Nn] ) 
                confirmed=false
                break;;
            "" )
                if [[ "$default_answer" == "y" || "$default_answer" == "Y" ]]; then
                    confirmed=true
                else
                    confirmed=false
                fi
                break;;
            * )
                log_error "Invalid input. Please answer yes [y|Y] or no [n|N].";;
        esac
    done

    echo $confirmed
}

prompt_user_for_value() {
    local value_name="$1"
    local default_value="$2"
    local value
    local message

    if [[ -z "$value_name" ]]; then
        log_error "Value name is required."
        return 1
    fi

    if [[ -z "$default_value" ]]; then
        log_warning "Default value is not provided. Entering empty value is not allowed."
        message="❓ Please enter $value_name: "
    else
        log_info "Default value is provided. Entering empty value will be replaced with default value: $2"
        message="❓ Please enter $value_name [default: $default_value]: "
    fi

    while true; do
        printf "%b" "$message" >&2
        read -e -r value
        if [[ -z "$value" ]]; then
            if [[ -n "$default_value" ]]; then
                value="$default_value"
                log_info "Using default value: $value"
                break
            else
                log_error "Empty value is not allowed."
                continue
            fi
        else
            break
        fi
    done

    echo "$value"
}
