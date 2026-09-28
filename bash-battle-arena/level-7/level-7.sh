#¡/bin/bash

#Level 7: File Sorting Script

#Mission: Write a script that sorts all .txt files in a directory by their size, from smallest to largest, and displays the sorted list.

DIRECTORY="Arena"

if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist."
    exit 1

fi

#Find all txt files → list them with sizes → sort by size column → show only size and filename
find "$DIRECTORY" -type f -name "*.txt" -exec ls -lh {} + | sort -k 5,5 -h | awk '{ print $5, $9 }'

