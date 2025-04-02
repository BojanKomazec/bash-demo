#!/usr/bin/env bash

# Fail on errors
# Mind that it prevents trap (function cleanup) functions to be called
# (unless they are set to be also triggered on ERR)
# set -e

# set +x

# include other bash scripts
source ./modules/bash_builtin_commands/echo.sh
source ./modules/bash_builtin_commands/mapfile.sh
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


print_usage() {
    echo "Usage: $0 [--verbose] [--help]"
}

main() {
    echo "Bash version: $BASH_VERSION"

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


    VERBOSE=false
    # ENV=""
    # BRANCH=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
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
                shift # Move to the next argument
                ;;
        esac
    done

    # Validate mandatory arguments
#     if [[ -z "$ENV" || -z "$BRANCH" ]]; then
#         echo "Usage: $0 [--verbose] <environment> <branch>
# Environment: test, prod
# Branch: The branch on which the workflows will be run."
#         exit 1
#     fi

    # double quotes are required for variable expansion

    log_start "Running the demo script"
    # log_info "Environment: $ENV"
    # log_info "Branch: $BRANCH"
    log_info "Verbose: $VERBOSE"


    # cmp_demo
    # data_structures_demo
    # dirname_demo
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
    prompt_demo
    read_demo
    # working_dir_demo

    log_finish "Finished running the demo script"
}

main "$@"
