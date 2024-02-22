#!/bin/bash

# This script downloads a bash script from https://signitron.com/scripts/ location (the first argument) and runs it.

# Check if the first argument is given. If not, show usage and list of all scripts in the online repository.
if [ -z "$1" ]; then
    echo "Usage: hdcs <script> | update"
    echo "Available scripts:"
    curl -k https://signitron.com/scripts/ | grep "a href" | awk '{ print $5 }' | sed 's/href="//g' | awk -F\> '{ print $2 }' | awk -F\< '{ print $1 }' | grep -v Name | grep -v Parent
    exit 1
fi

# If first parameter is "update", update the script itself
if [ "$1" == "update" ]; then
    echo "Updating hdcs..."
    curl -k -s https://signitron.com/scripts/hdcs.sh > /opt/hdcs/hdcs.sh
    chmod +x /opt/hdcs/hdcs.sh
    echo "hdcs updated!"
    exit 0
fi

# If the firt parameter is "install", install the script itself
if [ "$1" == "install" ]; then
    echo "Installing hdcs..."
    mkdir -p /opt/hdcs
    curl -k -s https://signitron.com/scripts/hdcs.sh > /opt/hdcs/hdcs.sh
    chmod +x /opt/hdcs/hdcs.sh
    echo "hdcs installed!"
    exit 0
fi

# If the first parameter is NOT install NOR update, check, if $1 is an existing script
curl -k https://signitron.com/scripts/ | grep "a href" | awk '{ print $5 }' | sed 's/href="//g' | awk -F\> '{ print $2 }' | awk -F\< '{ print $1 }' | grep -v Name | grep -v Parent \
                                       | grep -q "^$1$"

# If the script is not found, show usage and list of all scripts in the online repository.
if [ "$?" -ne "0" ]; then
    echo "Usage: hdcs <script> | install | update"
    echo "Available scripts:"
    curl -k https://signitron.com/scripts/ | grep "a href" | awk '{ print $5 }' | sed 's/href="//g' | awk -F\> '{ print $2 }' | awk -F\< '{ print $1 }' | grep -v Name | grep -v Parent
    exit 1
fi

# Download the selected script and run it locally
curl -k -s https://signitron.com/scripts/$1 | bash

# If the above command chain fails, show "Error: Script download and execution failed"
if [ "$?" -ne "0" ]; then
    echo "Error: Script download and execution failed"
    exit 1
fi

# All done
exit 0