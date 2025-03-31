#!/usr/bin/env bash

source "./modules/util/log.sh"
source "./modules/util/prompt.sh"

test_confirmation_prompt(){
    local message="Do you want to proceed?"
    local default_answer="y"
    local confirmed
    confirmed=$(prompt_user_for_confirmation "$message" "$default_answer")
    
    if [ "$confirmed" == true ]; then
        log_info "User confirmed."
    else
        log_info "User did not confirm."
    fi

    if $confirmed; then
        log_info "User confirmed."
    else
        log_info "User did not confirm."
    fi

    if ! $confirmed; then
        log_info "User did not confirm."
    else
        log_info "User confirmed."
    fi
}

test_prompt_user_for_value_without_default_value() {
    log_info "\ntest_prompt_user_for_value_without_default_value()"

    local value_name="Test Value"
    local value
    value=$(prompt_user_for_value "$value_name")

    if [[ -z "$value" ]]; then
        log_info "User did not provide a value."
    else
        log_info "User provided a value: $value"
    fi
}

test_prompt_user_for_value_with_default_value() {
    log_info "\ntest_prompt_user_for_value_with_default_value()"

    local value_name="Test Value"
    local default_value="Default Value"
    local value
    value=$(prompt_user_for_value "$value_name" "$default_value")
    
    if [[ -z "$value" ]]; then
        log_info "User did not provide a value."
    else
        log_info "User provided a value: $value"
    fi
}