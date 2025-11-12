#!/bin/bash
# ==========================================
# Script: check_sudo_access.sh
# Description: Lists all users with sudo privileges.
# ==========================================

echo "=== Users with Sudo Access ==="
grep '^sudo:.*$' /etc/group | cut -d: -f4 | tr ',' '\n'

