#!/bin/bash
# ==========================================
# Script: remove_user.sh
# Description: Safely deletes a user after confirmation, backs up home directory,
# and logs the operation for auditing.
# Usage: sudo ./remove_user.sh <username>
# Author: Shivali Kakade
# ==========================================

# set -e
# set -u
# set -o pipefail

USER=$1
BACKUP_DIR="/backup"
LOG_FILE="/var/log/user_management.log"

# Check if username is provided
if [ -z "$USER" ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

# Check if user exists
if ! id "$USER" &>/dev/null; then
  echo "User '$USER' does not exist."
  exit 2
fi

# Confirm deletion
read -p "Are you sure you want to delete user '$USER'? (y/n): " confirm
if [ "$confirm" != "y" ]; then
  echo "Operation cancelled."
  exit 0
fi

# Ensure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Backup home directory if it exists
if [ -d "/home/$USER" ]; then
  BACKUP_FILE="$BACKUP_DIR/${USER}_home_backup_$(date +%F_%H-%M-%S).tar.gz"
   sudo tar -czf "$BACKUP_FILE" -C /home "$USER"
  echo "Backup created at $BACKUP_FILE"
else
  echo "No home directory to backup for user '$USER'."
fi

# Delete the user and their home directory
sudo userdel -r "$USER" 2>/dev/null
echo "User '$USER' removed successfully."

# Log the deletion
echo "$(date '+%F %T') : User '$USER' deleted. Backup: ${BACKUP_FILE:-None}" | sudo tee -a "$LOG_FILE"

echo "Operation completed and logged in $LOG_FILE"

