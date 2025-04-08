#!/usr/bin/env bash

source "./modules/util/log.sh"

log_test() {
    log_trace "This is a trace message"
    log_debug "This is a debug message"
    log_info "This is an info message"
    log_warning "This is a warning message"
    log_error "This is an error message"
    log_fatal "This is a fatal message"
    log_success "This is a success message"
    # log_error_and_exit "This is an error message and exit"
    log_wait "This is a wait message"
    log_start "This is a start message"
    log_skip "This is a skip message"
    log_finish "This is a finish message"
    log_prompt "Please select an option:"


    local name="Anne"
    log_info "This is a message with a variable: $name"
    log_info "This is a message with a variable and escape: \n\t\t$name"
    log_info "This is a message with a variable and escape: \\n\\t\\t$name"

    # Expressions don't expand in single quotes, use double quotes for that.
    log_info 'This is a message with a variable and escape: \n\t\t$name'

    log_info $'This is a message with a variable and escape: \\n\\t\\t'"$name"'\\t.'

    # This is how to pass strings with escape characters to the log functions if they use %s.
    # The variable is expanded because the string is in double quotes.
    # log_info $'This is a message with a variable and escape: \n\t\t'"$name"$'\t.'

    log_array_elements "false" "one" "two" "three"
    log_array_elements "true" "one" "two" "three"

    print_index=false
    array_numbers=("one" "two" "three")
    log_array_elements "$print_index" "${array_numbers[@]}"

    print_index=true
    log_array_elements "$print_index" "${array_numbers[@]}"
}
