#!/bin/bash

# This script downloads a bash script from https://signitron.com/scripts/ location (the first argument) and runs it.

# Check if the first argument is given
if [ -z "$1" ]; then
    echo "Usage: hdcs <script>"
    exit 1
fi

# Download the script and run it
curl -k https://signitron.com/scripts/$1 | bash

# All done
exit 0