#!/usr/bin/env bash

# Fail on errors
# Mind that it prevents trap (function cleanup) functions to be called
# (unless they are set to be also triggered on ERR)
# set -e

# set +x

# include other bash scripts
source ./modules/bash_builtin_commands/echo.sh
source ./modules/data_structures.sh
source ./modules/file_io.sh
source ./modules/operators_demo.sh
source ./modules/strings_demo.sh
source ./modules/filesystem_demo.sh
source ./modules/strings_demo.sh
source ./modules/unix_tools/file_and_dir_management.sh
source ./modules/unix_tools/file_comparison.sh
source ./modules/unix_tools/test_demo.sh
source ./modules/unix_tools/text_processing.sh
source ./modules/util/log.sh


print_usage() {
    echo "Usage: $0 [--verbose] [--help]"
}

main() {
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

    
    log_start "Running the demo script"
    # log_info "Environment: $ENV"
    # log_info "Branch: $BRANCH"
    log_info "Verbose: $VERBOSE"

    echo_demo
    # test_demo
    # string_demo
    # cmp_demo
    # file_and_dir_management_tools_demo
    # json_parsing_with_grep
    # array_demo
    # array_demo2
    # ln_demo
    # operators_demo
    # working_dir_demo
    # substring_removal_demo
    # file_io_demo
    # shell_built_in_commands_demo

    log_finish "Finished running the demo script"
}

main "$@"