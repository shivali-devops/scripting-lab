#!/usr/bin/env bash
# ============================================================
# Script Name: system_health_report.sh
# Description: Prints CPU, memory, and disk usage summary.
# Usage: ./system_health_report.sh
# Author: Shivali Kakade
# ============================================================

LOG="/var/log/sys-checks.log"
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
mem_usage=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
disk_usage=$(df -h / | awk 'NR==2 {print $5}')

echo "===== System Health Report ($timestamp) ====="
echo "CPU Usage : $cpu_usage%"
echo "Memory    : $mem_usage%"
echo "Disk      : $disk_usage"

echo "$timestamp [INFO] System health report generated" | tee -a "$LOG"