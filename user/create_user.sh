#!/bin/bash
####################
#
# script : create_user.sh
# Description: Creates a new user with a home directory and optional sudo access.
# temporary password, and forces password change on first login.
# Usage: sudo ./create_user.sh <username> [sudo]
#
####################

# -e → exit on error
# -u → treat unset variables as errors
# -o pipefail → detect errors even in piped commands
set -eo pipefail   


USER=$1
SUDO_FLAG=$2

# Exit if no username is provided
if [ -z "$USER" ]; then
	 echo "Usage: $0 <username> [sudo]"
	 exit 1
fi

# Check if user already exists
if id "$USER" &>/dev/null; then
	 echo "User '$USER' already exists!"
	 exit 2
fi

# Create the user with home directory and BASH shell
sudo useradd -m -s /bin/bash "$USER"
echo "User '$USER' created succesfully with home directory and BASH shell"

# Generate a secure temporary password
TEMP_PASS=$(openssl rand -base64 8)
echo "$USER:$TEMP_PASS" | sudo chpasswd
echo "Temporary password: $TEMP_PASS"

# Force password change on first login
sudo chage -d 0 "$USER"


# Optional: Add to sudo group if second argument is 'sudo'
if [ "$SUDO_FLAG" == "sudo" ]; then
	sudo usermod -aG sudo "$USER"
	echo "User '$USER' is added to sudo group"
fi

echo "$USER setup completed. They must change the password on first login."








