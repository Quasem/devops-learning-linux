#¡/bin/bash 
#Level 4: File Manipulation

#Mission: Create a script that copies all .txt files from the Arena directory to a new directory called Backup.
mkdir -p Backup

# Copy all .txt files from Arena to Backup
echo "--- Copying .txt files to Backup ---"
cp Arena/*.txt Backup/  
echo "Copy complete."

# List both directories to confirm
echo "--- Arena contains ---"
ls -l Arena

echo "--- Backup contains ---"
ls -l Backup


