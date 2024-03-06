#!/bin/bash

echo "Starting script..."

# ASCII Art for Bash FTP on execution.
echo " ______  _______  _______  _______      _______  _______  ______ "
echo "|   __ \\|   _   ||     __||   |   |    |    ___||_     _||   __ \\"
echo "|   __ <|       ||__     ||       |    |    ___|  |   |  |    __/"
echo "|______/|___|___||_______||___|___|    |___|      |___|  |___|   "
echo "                                                                 "
echo "                                                                 "


LOCAL_DIR="/Users/USER/Downloads/complete" #enter your directory path to upload files from locally
SERVER="192.168.68.118:2525"
USERNAME="username"
PASSWORD="password"
REMOTE_DIR="/ready"
LOG_FILE="/Users/USER/downloads/uploaded_files.log" #enter your filepath username where "USER" for correct logging. 
DELAY_SECONDS=0

# Function to log successful file transfer
log_transfer() {
    local file=$1
    echo "[$(date)] Transfer successful for $file" >> "$LOG_FILE" || echo "Error logging transfer of $file"
}

# Function to check if a log entry exists for a file
log_exists() {
    local file=$1
    grep -qF "$file" "$LOG_FILE"
    return $?
}

# Function to transfer and log specific file
transfer_and_log_file() {
    local file=$1
    echo "Transferring $file..."
    lftp -e "put \"$file\" -o '$REMOTE_DIR/$(basename "$file")'; bye" -u $USERNAME,$PASSWORD $SERVER

    if [ $? -eq 0 ]; then
        echo "Transfer of $file successful."
        log_transfer "$file"
        rm "$file" # Remove file after successful transfer
    else
        echo "Transfer of $file failed."
    fi
}

# Function to monitor and sync directory
monitor_and_sync() {
    fswatch -o "$LOCAL_DIR" | while read
    do
        echo "Change detected.."
        sleep $DELAY_SECONDS

        # Transfer new or modified files
        find "$LOCAL_DIR" -type f -print0 | while IFS= read -r -d '' file
        do
            if ! log_exists "$file"; then
                transfer_and_log_file "$file"
            fi
        done
    done
}

# Continuous loop to restart the process after completion
while true; do
    monitor_and_sync
    echo "Process completed. Restarting..."
done
