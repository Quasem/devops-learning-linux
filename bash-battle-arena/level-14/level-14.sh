#¡/bin/bash

#Level 14: User-Friendly Menu Script

#Mission: Create an interactive script that presents a menu with options for different system tasks (e.g., check disk space, show system uptime, list users), and executes the chosen task.

echo "Welcome to the System Task Menu"
echo "1. Check Disk Space"
echo "2. Show System Uptime"
echo "3. List Users"
read -p "Please enter your choice (1-3): " choice

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
        echo "Listing Users..."
        cut -d: -f1 /etc/passwd
        ;;
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac    

