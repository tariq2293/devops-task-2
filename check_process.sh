#!/bin/bash

#EXERCISE 3: Bash Script - User Processes

# Check if USER environment variable is set
if [ -z "$USER" ]; then
    echo "USER environment variable is not set."
    exit 1
fi

# Use ps aux command and grep for the current user
echo "Processes running for user $USER:"
ps aux | grep "^$USER" | grep -v grep

