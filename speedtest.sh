#!/bin/bash

# This script installs speedtest-cli by Ookla (for Debian) and runs a speedtest.

# Check if speedtest is installed. If not, install it.
if [ -x "$(command -v speedtest)" ]; then
    echo "speedtest is already installed. Running test..."
else
    echo "speedtest is not installed. Installing..."
    sudo apt-get install curl
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
    sudo apt-get install speedtest
    # First run of the speedtest: accept the license
    echo -e "yes\nyes" | speedtest
    exit 0
fi

# Running the test

speedtest -s 30620

# Done! Great and exit.
echo "Done!"
exit 0