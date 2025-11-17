#!/usr/bin/env bash
# ============================================================
# Script Name: memory_check.sh
# Description: Displays memory usage details.
# Usage: sudo ./memory_check.sh
# Author: Shivali Kakade
# ============================================================

LOG="/var/log/memory_check.log"
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

mem_used=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')

if ((${mem_used%.*} > 80)); then
    echo "$timestamp - WARNING: High memory usage detected: ${mem_used}% used." >> $LOG
else
    echo "$timestamp - Memory usage is normal: ${mem_used}% used." | tee -a $LOG
fi