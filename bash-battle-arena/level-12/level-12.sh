#¡/bin/bash
#Level 12: Simple Configuration File Parser

#Mission: Write a script that reads a configuration file in the format KEY=VALUE and prints each key-value pair.

CONFIG_FILE="settings.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found: $CONFIG_FILE"
    exit 1
fi

echo "--- Reading configuration from $CONFIG_FILE ---"

while IFS='=' read -r key value; do
    if [[ -z "$key" || "$key" == \#* ]]; then
        continue
    fi
    echo "Key: $key, Value: $value"
done < "$CONFIG_FILE"

echo "--- Done ---"
