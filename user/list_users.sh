#!/bin/bash
# ==========================================
# Script: list_users.sh
# Description: Lists all normal (human) users on the system.
# Usage: ./list_users.sh
# ==========================================

echo "=== Normal System Users ==="

# Filter users with UID >= 1000 (normal users), exclude 'nobody'
awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd

echo "=== End of List ==="

