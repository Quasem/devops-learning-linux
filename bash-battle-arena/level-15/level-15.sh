#¡/bin/bash
#Level 15: Boss Battle 3 - Advanced Scripting

#Combine the skills you've gained! Write a script that:
#1. Presents a menu to the user with the following options:

#- Check disk space
#- Show system uptime
#- Backup the Arena directory and keep the last 3 backups
#- Parse a configuration file settings.conf and display the values

#2. Execute the chosen task.

SOURCE_DIR="Arena"
BACKUP_DIR="Backup"
MAX_BACKUPS=3

echo "Welcome to the System Task Menu"
echo "1. Check Disk Space"
echo "2. Show System Uptime"
echo "3. Backup the Arena directory (keep last 3 backups)"
echo "4. Parse configuration file settings.conf"
read -p "Please enter your choice (1-4): " choice   

case $choice in
    1)
        echo "Checking Disk Space..."
        df -h
        ;;
    2)
        echo "Showing System Uptime..."
        uptime
        ;;
    3)
        mkdir -p Arena 
        echo "Backing up the Arena directory..."
        BACKUP_DIR="Arena_Backups"
        mkdir -p "$BACKUP_DIR"
        TIMESTAMP=$(date +%Y%m%d%H%M%S)
        tar -czf "$BACKUP_DIR/Arena_backup_$TIMESTAMP.tar.gz" Arena
        echo "Backup created: $BACKUP_DIR/Arena_backup_$TIMESTAMP.tar.gz"

        # Keep only the last 3 backups
        ls -1t "$BACKUP_DIR"/Arena_backup_*.tar.gz | tail -n +4 | xargs rm -f
        echo "Kept the last 3 backups."
        ;;
    4)
        echo "Parsing configuration file settings.conf..."
        if [ -f "settings.conf" ]; then
            while IFS='=' read -r key value; do
                echo "$key = $value"
            done < settings.conf
        else
            echo "Configuration file settings.conf not found."
        fi
        ;;
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac    

