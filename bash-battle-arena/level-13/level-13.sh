#¡/bin/bash

#Level 13: Backup Script with Rotation

#Mission: Create a script that backs up a directory to a specified location and keeps only the last 5 backups

# Set the source directory and backup destination
SOURCE_DIR="Arena"
BACKUP_DIR="Backup"
MAX_BACKUPS=5

# Create the backup directory if it doesn't exist
mkdir -p "$SOURCE"
mkdir -p "$BACKUP_DIR"

# Create some test files in Arena 
touch "$SOURCE/file1.txt"
touch "$SOURCE/file2.txt"
echo "Important data" > "$SOURCE/data.txt"

# Create backup with timestamp
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

echo "--- Creating backup: $BACKUP_FILE ---"
tar -czf "$BACKUP_FILE" "$SOURCE"
echo "Backup created successfully."

# Count current backups
BACKUP_COUNT=$(ls -t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | wc -l)
echo "Total backups: $BACKUP_COUNT"

# Remomve old backups keeping only the last 5
if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    echo "--- Removing old backups ---"
    ls -t "$BACKUP_DIR"/*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | while read old_backup; do
        rm "$old_backup"
        echo "Removed $old_backup"
    done
fi 

echo "--- Current backups ---"
ls -1h "$BACKUP_DIR"/*.tar.gz

echo "--- Done ---"
