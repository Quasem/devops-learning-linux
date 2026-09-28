#¡/bin/bash
#Level 11: Automated Disk Space Report

#Mission: Create a script that checks the disk space usage of a specified directory and sends an alert if the usage exceeds a given threshold.

#1. Set a threshold (e.g. 80%)
#2. Get the current disk usage percentage
#3. If usage is above threshold → print alert
#4. If usage is below threshold → print ok message


# Set the threshold percentage
THRESHOLD=80

# Get the current disk usage percentage of the specified directory (Arena)
USAGE=$(df -h Arena | awk 'NR==2 {print $5}' | tr -d '%')

echo "Current disk usage of Arena: $USAGE%"
echo "Threshold set at: $THRESHOLD%"

# Check if the current usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Alert: Disk usage exceeds threshold! Current usage is $USAGE%."
else
    echo "Disk usage is within acceptable limits. Current usage is $USAGE%."
fi

