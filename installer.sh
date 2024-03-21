#!/bin/bash

# Install sudo, curl, git, nano
sudo apt-get update
sudo apt-get install -y sudo curl git nano

# Move to /opt
cd /opt

# Clone the repository
git clone https://github.com/tomcatcher/scripts.git

# Chmod all the scripts
chmod +x /opt/scripts/*.sh

# Add the scripts to the PATH system-wide
echo "export PATH=\$PATH:/opt/scripts" >> /etc/profile

# Exit with status code 0
exit 0