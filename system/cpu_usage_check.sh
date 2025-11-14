#!/usr/bin/env bash

# ============================================================
# Script Name: cpu_check.sh
# Description: Monitors CPU usage and prints alert if threshold is crossed.
# Usage: ./cpu_check.sh
# Author: Shivali Kakade
# ============================================================

LOG_FILE="/var/log/cpu_usage.log"
THRESHOLD=80
DATE=$(date '+%Y-%m-%d %H:%M:%S')

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage_int=${cpu_usage%.*}

if (( cpu_usage_int > THRESHOLD )); then
    echo "$DATE - ALERT: CPU usage is at ${cpu_usage_int}%" | tee -a "$LOG_FILE"
else
    echo "$DATE - CPU usage is normal at ${cpu_usage_int}%" | tee -a "$LOG_FILE"
fi