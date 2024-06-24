#!/bin/bash

#EXERCISE 5: Bash Script - Number of User Processes Sorted

echo "Sort by (memory/cpu):"
read sort_by
echo "Number of processes to display:"
read limit

if [[ "$sort_by" == "memory" ]]; then
    ps aux | grep $USER | sort -nrk 4 | head -n $limit
elif [[ "$sort_by" == "cpu" ]]; then
    ps aux | grep $USER | sort -nrk 3 | head -n $limit
else
    echo "Invalid option."
fi

