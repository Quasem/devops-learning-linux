#¡/bin/bash

#Level 10: Boss Battle 2 - Intermediate Scripting

#Mission: Write a script that:
#1. Creates a directory called Arena_Boss.
#2. Creates 5 text files inside the directory, named file1.txt to file5.txt.
#3. Generates a random number of lines (between 10 and 20) in each file.
#4. Sorts these files by their size and displays the list.
#5. Checks if any of the files contain the word 'Victory', and if found, moves the file to a directory called Victory_Archive.

# Step 1: Create Arena_Boss directory
mkdir -p Arena_Boss

# Step 2: Create 5 text files
for i in {1..5}; do 
    touch "Arena_Boss/file$i.txt"
done

for i in {1..5}; do
    # Step 3: Generate a random number of lines (between 10 and 20) in each file
    RANDOM_LINES=$((RANDOM % 11 + 10)) # Random number between 10 and 20
    for j in $(seq 1 $RANDOM_LINES); do
        echo "This is line $j in file$i.txt" >> "Arena_Boss/file$i.txt"
    done
done

# Step 4: Sort files by size and display the list
echo "--- Files sorted by size ---"
ls -lSr Arena_Boss/*.txt

# Step 5: Check for 'Victory' in files and move to Victory_Archive if found
mkdir -p Victory_Archive
for file in Arena_Boss/*.txt; do
    if grep -q "Victory" "$file"; then
        mv "$file" Victory_Archive/
        echo "Moved $file to Victory_Archive"
    fi
done    
echo "--- Victory_Archive contains ---"
ls -l Victory_Archive