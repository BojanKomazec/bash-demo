#!/usr/bin/env bash

read_demo(){
#!/bin/bash
    read -p "Enter command: " user_input
    echo "You typed: $user_input"

    read -r -p "Enter command: " user_input
    echo "You typed: $user_input"

    read -e -p "Enter command: " user_input
    echo "You typed: $user_input"

    read -e -r -p "Enter command: " user_input
    echo "You typed: $user_input"
}
