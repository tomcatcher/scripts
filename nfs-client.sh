#!/bin/bash

# This scripts sets up a machine in a way that it automatically mounts the remote export on boot.

# Install NFS cient SW
echo "Installing NFS client SW"
apt update
apt -y install nfs-common
echo "NFS client installed!"

# Create a folder to mount the remote export, but first check if user catcher exists. If not, create it (with UID and GID 1000, if possible).
id -u catcher &>/dev/null || useradd catcher -d /home/catcher -m -s /bin/bash

# Create a folder to mount the remote export
mkdir /home/catcher/remote

# Add the mount to /etc/fstab
echo "10.2.2.2:/mnt/export /home/catcher/remote nfs rw,defaults 0 0" >> /etc/fstab

# Reboot the machine
echo "Rebooting..."
reboot &
exit 0