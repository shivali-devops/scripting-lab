#!/bin/bash
# ==========================================
# Script: list_active_users.sh
# Description: Lists all users currently logged into the system.
# Usage: ./list_active_users.sh
# Author: Shivali Kakade
# ==========================================

echo "=== Active Users Currently Logged In ==="

# 'who' lists logged-in sessions; sort & uniq ensures unique usernames
who | awk '{print $1}' | sort | uniq

echo "=== End of Active Users ==="

