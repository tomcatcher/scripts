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
    chmod +x /opt/hdcs.hdcs.sh
    echo "hdcs updated!"
    exit 0
fi

# DEBGUG: Print the first argument
echo "The first argument is: $1"

# Download the script and run it
curl -k -s https://signitron.com/scripts/$1 | bash

# All done
exit 0