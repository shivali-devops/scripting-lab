#!/usr/bin/env bash
# ============================================================
# Script Name: disk_cleanup.sh
# Description: Removes log files older than 7 days.
# Usage: sudo ./disk_cleanup.sh
# Author: Shivali Kakade
# ============================================================

LOG_DIR="/var/log/sys_log.log"
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
DAYS_OLD=${1:-7}

# Directories to clean
TARGET_DIRS=("/tmp" "/var/log")

echo "$timestamp [INFO] Cleaning files older than $DAYS_OLD days in $TARGET_DIR" | tee -a "$LOG_DIR"

# Loop through target directories and delete old files
for d in "${TARGET_DIRS[@]}"; do
    find "$d" -type f -mtime +$DAYS_OLD -exec rm -f {} \;
    
    # Check if the find command was successful
    if [ $? -eq 0 ]; then
        echo "$timestamp [INFO] Disk cleanup completed successfully." | tee -a "$LOG_DIR"
    else
        echo "$timestamp [ERROR] Disk cleanup encountered errors." | tee -a "$LOG_DIR"
    fi
done