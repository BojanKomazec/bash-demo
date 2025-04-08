#!/usr/bin/env bash

read_basic_demo(){
    read -p "Enter command: " user_input
    echo "You typed: $user_input"

    read -r -p "Enter command: " user_input
    echo "You typed: $user_input"

    read -e -p "Enter command: " user_input
    echo "You typed: $user_input"

    read -e -r -p "Enter command: " user_input
    echo "You typed: $user_input"
}

read_with_prompt(){
    read -p "Enter command: " user_input
    echo "You typed: $user_input"
}

# The read command does not process escape sequences by default. It simply takes the string provided in the -p option and displays it as-is.
read_with_prompt_message_which_includes_escape_char(){
    log_info "read_with_prompt_message_which_includes_escape_char()"

    read -e -r -p "\nEnter command: " user_input
    echo "You typed: $user_input"

    # Fix:
    printf "\nEnter command:"
    read -e -r user_input
    echo "You typed: $user_input"

    # Fix #2:
    echo -e "\nEnter command: "
    read -e -r user_input
    echo "You typed: $user_input"
}

read_with_timeout(){
    read -t 5 -p "Enter command (timeout in 5 seconds): " user_input
    if [ $? -eq 0 ]; then
        echo "You typed: $user_input"
    else
        echo "Timeout occurred!"
    fi
}

read_yes_no(){
    printf "\nDo you want to proceed? (y/n): "
    read -e -r confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        echo "You confirmed!"
    elif [[ $confirm =~ ^[Nn]$ ]]; then
        echo "You declined!"
    else
        echo "Invalid input!"
    fi
}

read_demo(){
    log_info "read_demo()"
    # read_basic_demo
    # read_with_prompt
    read_with_prompt_message_which_includes_escape_char
    # read_yes_no
    # read_with_timeout
}
