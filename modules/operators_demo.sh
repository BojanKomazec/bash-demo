#!/usr/bin/env bash

operators_demo() {
    number0=0

    if [ $number0 == 0 ]; then
    echo "number0 is zero"
    else
    echo "number0 is not zero"
    fi

    if [ $number0 -eq 0 ]; then
    echo "number0 is zero"
    else
    echo "number0 is not zero"
    fi
}