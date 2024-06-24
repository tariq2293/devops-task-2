#!/bin/bash

#EXERCISE 4: Bash Script - User Processes Sorted

echo "Sort by (memory/cpu):"
read sort_by

if [[ "$sort_by" == "memory" ]]; then
    ps aux | grep $USER | sort -nrk 4
elif [[ "$sort_by" == "cpu" ]]; then
    ps aux | grep $USER | sort -nrk 3
else
    echo "Invalid option."
fi
