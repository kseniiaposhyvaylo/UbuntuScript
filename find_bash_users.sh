#!/bin/bash

# Ensure the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
  echo "Error: Please run this script as root or using sudo."
  exit 1
fi

# Define the path to the passwd file
PASSWD_FILE="/etc/passwd"

# Check if the passwd file exists
if [[ ! -e $PASSWD_FILE ]]; then
  echo "Error: $PASSWD_FILE not found."
  exit 1
fi

# Search for users with /bin/bash CLI
USERS_WITH_BASH=$(awk -F: '/\/bin\/bash$/{print $1}' "$PASSWD_FILE")

# Check the exit status of awk
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to extract users. Please check the script."
  exit 1
fi

# Check if any users were found
if [[ -z $USERS_WITH_BASH ]]; then
  echo "No users found with /bin/bash CLI."
else
  echo "Users with /bin/bash CLI:"
  echo "$USERS_WITH_BASH"
fi

exit 0

