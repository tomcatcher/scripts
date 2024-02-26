#!/bin/bash

# Ths script installs sudo, sets up catcher user for any command without password and logs oUt the current session.

# Check if sudo is installed. If not, install it.
if [ -x "$(command -v sudo)" ]; then
    echo "sudo is already installed."
else
    echo "sudo is not installed. Installing..."
    apt update
    apt -y install sudo
    echo "sudo installed!"
fi

# Add catcher user to sudoers, but first check, if user catcher exists. If not, create it. Assume this script is being run as root.
id -u catcher &>/dev/null || useradd -u 1000 catcher -d /home/catcher -m -s /bin/bash

# Add catcher to sudoers
echo "catcher ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/catcher

# Log out
echo "Log out..."
exit 0