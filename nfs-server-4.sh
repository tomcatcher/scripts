#!/usr/bin/bash
# Install NFS server

# Update APT
apt update

# APT upgrade
apt -y upgrade

# Install NFS server
apt -y install nfs-kernel-server rpcbind

# Create folder to be exported
mkdir /mnt/export

# Set up users and groups
groupadd -g 1000 catcher
useradd -u 1000 -g 1000 catcher

# Set up ACL on flder to be exported
chown catcher:catcher /mnt/export

# Set up NFS exports in /etc/exports
# /mnt/export 10.0.0.0/24(rw,sync,no_subtree_check,anonuid=33,anongid=33)
echo "/mnt/export 10.0.0.0/24(rw,sync,no_subtree_check,anonuid=1000,anongid=1000)" > /etc/exports

# Restart nfs-kernel-server and nfs-server
systemctl restart nfs-kernel-server
systemctl restart nfs-server

# Export all
export -a

# Done
echo "Done!"
exit 0