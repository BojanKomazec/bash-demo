#!/usr/bin/env bash

# Fail on errors
# Mind that it prevents trap (function cleanup) functions to be called
# (unless they are set to be also triggered on ERR)
# set -e

# set +x

# include other bash scripts
source ./modules/bash_builtin_commands/declare.sh
source ./modules/bash_builtin_commands/echo.sh
source ./modules/bash_builtin_commands/mapfile.sh
source ./modules/bash_builtin_commands/printf.sh
source ./modules/bash_builtin_commands/read.sh
source ./modules/data_structures.sh
source ./modules/conditional_statements.sh
source ./modules/file_io.sh
source ./modules/functions_demo.sh
source ./modules/operators_demo.sh
source ./modules/strings_demo.sh
source ./modules/filesystem_demo.sh
source ./modules/strings_demo.sh
source ./modules/unix_tools/file_and_dir_management.sh
source ./modules/unix_tools/file_comparison.sh
source ./modules/unix_tools/networking.sh
source ./modules/unix_tools/test_demo.sh
source ./modules/unix_tools/text_processing.sh
source ./modules/util/log.sh
source ./modules/util/prompt.sh
source ./modules/util/prompt_test.sh
source ./modules/util/log_test.sh


# Function to display usage/help
print_usage() {
    echo "Usage: $0 -u|--user <username> -p|--password <password> [-h|--help] [-v|--verbose]"
    echo "       $0 -e|--env-file <path_to_env_file>"
    echo "Options:"
    echo "  -u, --user      Specify the username (requires a value)"
    echo "  -p, --password  Specify the password (requires a value)"
    echo "  -h, --help      Display this help message"
    echo "  -v, --verbose   Enable verbose mode"
    echo "  -e, --env-file  Specify the path to the environment file (default: .env)"
}

# Function to validate option value
# Note that this function does not allow user or password to be empty or to start with a dash (-) or double dash (--).
validate_argument_value() {
    local option="$1"
    local value="$2"
    if [[ -z "$value" || "$value" == --* || "$value" == -* ]]; then
        log_error "Option '$option' requires a non-empty value which does not start with a dash (-) or double dash (--)."
        print_usage
        exit 1
    fi
}

validate_mandatory_argument() {
    local value="$1"
    if [[ -z "$value" ]]; then
        log_error "Option '$2' is mandatory and requires a non-empty value."
        print_usage
        exit 1
    fi
}

# Usage: print_arguments_in_current_context <arg1> <arg2> ...
#        prin   t_arguments_in_current_context "$@"
print_arguments_in_current_context() {
    log_debug "Current arguments: $@"
    log_array_elements "$@"
}

print_script_info() {
    log_debug "Current arguments: $@"
    log_debug "Current working directory: $(pwd)"
    log_debug "Current script directory: $(dirname "$0")"
    log_debug "Current script name: $(basename "$0")"
    log_debug "Current script PID: $$"
    log_debug "Current script UID: $UID"
    log_debug "Current script EUID: $EUID"
    log_debug "Current script PPID: $PPID"
    log_debug "Current script PWD: $PWD"
    log_debug "Current script SHELL: $SHELL"
    log_debug "Current script BASH_VERSION: $BASH_VERSION"
    log_debug "Current script BASH_ENV: $BASH_ENV"
    log_debug "Current script BASH_LINENO: ${BASH_LINENO[*]}"
    log_debug "Current script BASH_SUBSHELL: $BASH_SUBSHELL"
    log_debug "Current script BASH_SOURCE: ${BASH_SOURCE[*]}"
    log_debug "Current script BASH_EXECUTION_STRING: $BASH_EXECUTION_STRING"
    log_debug "Current script BASH_ARGC: ${BASH_ARGC[*]}"
    log_debug "Current script BASH_ARGV: ${BASH_ARGV[*]}"
    log_debug "Current script BASH_COMMAND: $BASH_COMMAND"
    log_debug "Current script BASH_ENV: $BASH_ENV"
    log_debug "Current script ENV: $ENV"
    log_debug "Current script PATH: $PATH"
    log_debug " Current script SHELL: $SHELL"
    which curl
}

# By default, bash doesn't always enable special key processing depending on how the script is being run
# Up = ^[[A
# Down = ^[[B
# Right = ^[[C
# Left = ^[[D
#
# # Enable arrow key support
# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'
# bind '"\e[C": forward-char'
# bind '"\e[D": backward-char'
#
# # Save terminal settings
# old_settings=$(stty -g)
#
# # Function to restore terminal settings
# cleanup() {
#     stty "$old_settings"
#     echo -e "\nExiting..."
#     exit 0
# }
#
# # Set trap to restore terminal on exit
# trap cleanup INT TERM EXIT
#
# # Prepare terminal for raw input
# stty raw -echo
#
# Here is the order of precedence for loading environment variables:
# 1. command line arguments
# 2. environment variables
# 3. default values
#
main() {
    log_start "Running the demo script.\nBash version: $BASH_VERSION"
    ENV_FILE=""

    if [[ $# -eq 0 ]]; then
        log_error "No arguments provided. Use -h or --help for usage information."
        exit 
    fi

    # Pre-parse --env-file and --verbose before loading environment
    log_debug "Pre-parsing arguments for --env-file..."
    # Iterate over all the arguments via index
    for ((i=1; i<=$#; i++)); do
        log_trace "Argument: ${!i}"
        if [[  "${!i}" == "-e" || "${!i}" == "--env-file" ]]; then
            # Get the next argument after --env-file
            j=$((i+1))
            log_trace "Next argument: ${!j}"
            ENV_FILE="${!j}"
            log_debug "Environment file: $ENV_FILE"
            validate_argument_value "--env-file" "$ENV_FILE"
            break
        elif [[ "${!i}" == "-v" || "${!i}" == "--verbose" ]]; then
            VERBOSE=true
            log_debug "Verbose mode enabled."
        fi
    done

    print_script_info "$@"

    if [[ -n "$ENV_FILE" ]]; then
        log_info "Using environment file: $ENV_FILE"

        # Load env file if it exists
        if [[ -f "$ENV_FILE" ]]; then
            # export $(grep -v '^#' "$ENV_FILE" | xargs)
            set -a
            source "$ENV_FILE"
            set +a
            log_info "Loaded environment variables from '$ENV_FILE'."
        else
            log_error_and_exit "Environment file '$ENV_FILE' not found."
        fi
    else
        log_info "No environment file specified. Using default values."
    fi

    USERNAME="${USERNAME:-}"
    PASSWORD="${PASSWORD:-}"
    VERBOSE=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -u|--user)
                validate_argument_value "$1" "$2"
                USERNAME="$2"
                shift 2
                ;;
            -p|--password)
                validate_argument_value "$1" "$2"
                PASSWORD="$2"
                shift 2
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -e|--env-file)
                validate_argument_value "$1" "$2"
                ENV_FILE="$2"
                shift 2
                ;;
            -h|--help)
                print_usage
                exit 0
                ;;
            # test|prod)
            #     ENV="$1"
            #     shift # Move to the next argument
            #     ;;
            *)
                echo "Unknown option: $1"
                print_usage
                exit 1
                ;;
        esac
    done

    validate_mandatory_argument "$USERNAME" "-u|--user"
    validate_mandatory_argument "$PASSWORD" "-p|--password"

    if [[ $VERBOSE -eq 1 ]]; then
        log_info "Verbose mode enabled."
    fi

    log_info "Username: $USERNAME"
    log_info "Password: $PASSWORD"
    log_info "Verbose: $VERBOSE"

    # cmp_demo
    # data_structures_demo
    # dirname_demo
    # declare_demo
    # echo_demo
    # file_and_dir_management_tools_demo
    # file_io_demo
    # functions_demo
    # json_parsing_with_grep
    # log_test
    # ln_demo
    # mapfile_demo
    networking_demo
    # operators_demo
    # string_checks_demo
    # string_demo
    # substring_removal_demo
    # shell_built_in_commands_demo
    # test_demo
    # printf_demo
    # prompt_demo
    # read_demo
    # working_dir_demo

    log_finish "Finished running the demo script"
}

main "$@"
