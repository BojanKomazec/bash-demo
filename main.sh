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
source ./modules/unix_tools/test_demo.sh
source ./modules/unix_tools/text_processing.sh
source ./modules/util/log.sh
source ./modules/util/prompt.sh
source ./modules/util/prompt_test.sh
source ./modules/util/log_test.sh

print_bash_version() {
    echo "Bash version: $BASH_VERSION"
}

# Function to display usage/help
print_usage() {
  echo "Usage: $0 -u <username> -p <password> [--help] [--verbose]"
  echo "       $0 --user <username> --password <password> [--help] [--verbose]"
  echo "Options:"
  echo "  -u, --user      Specify the username (requires a value)"
  echo "  -p, --password  Specify the password (requires a value)"
  echo "  -h, --help      Display this help message"
  echo "  -v, --verbose   Enable verbose mode"
}

# Function to validate option value
# Note that this function does not allow user or password to be empty or to start with a dash (-) or double dash (--).
validate_argument_value() {
    local value="$1"
    if [[ -z "$value" || "$value" == --* || "$value" == -* ]]; then
        echo "Error: Option '$2' requires a non-empty value which does not start with a dash (-) or double dash (--)."
        print_usage
        exit 1
    fi
}

validate_mandatory_argument() {
    local value="$1"
    if [[ -z "$value" ]]; then
        echo "Error: Option '$2' requires a non-empty value."
        print_usage
        exit 1
    fi
}

main() {
    log_start "Running the demo script"
    print_bash_version

    #  by default, bash doesn't always enable special key processing depending on how the script is being run
    # Up = ^[[A
    # Down = ^[[B
    # Right = ^[[C
    # Left = ^[[D

    # # Enable arrow key support
    # bind '"\e[A": history-search-backward'
    # bind '"\e[B": history-search-forward'
    # bind '"\e[C": forward-char'
    # bind '"\e[D": backward-char'

    # # Save terminal settings
    # old_settings=$(stty -g)

    # # Function to restore terminal settings
    # cleanup() {
    #     stty "$old_settings"
    #     echo -e "\nExiting..."
    #     exit 0
    # }

    # # Set trap to restore terminal on exit
    # trap cleanup INT TERM EXIT

    # # Prepare terminal for raw input
    # stty raw -echo

    # Initialize variables
    USERNAME=""
    PASSWORD=""
    VERBOSE=false
    # ENV=""
    # BRANCH=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -u|--user)
                validate_argument_value "$2" "$1"
                USERNAME="$2"
                shift 2
                ;;
            -p|--password)
                validate_argument_value "$2" "$1"
                PASSWORD="$2"
                shift 2
                ;;
            --verbose)
                VERBOSE=true
                shift # Move to the next argument
                ;;
            --help)
                print_usage
                exit 0
                ;;
            # test|prod)
            #     ENV="$1"
            #     shift # Move to the next argument
            #     ;;
            *)
                # BRANCH="$1"
                echo "Unknown option: $1"
                print_usage
                exit 1
                # shift
                ;;
        esac
    done

    validate_mandatory_argument "$USERNAME" "--user"
    validate_mandatory_argument "$PASSWORD" "--password"

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
    # operators_demo
    # string_checks_demo
    # string_demo
    # substring_removal_demo
    # shell_built_in_commands_demo
    # test_demo
    printf_demo
    # prompt_demo
    # read_demo
    # working_dir_demo

    log_finish "Finished running the demo script"
}

main "$@"
