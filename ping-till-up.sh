#!/bin/bash

# This script pings a remote host until it is up. It is useful for waiting for services to start.
# Usage: ping-till-up.sh <host> <timeout> <interval>
# Example: ping-till-up.sh google.com 60 5

# Check if the correct number of arguments was provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <host> <timeout> <interval>"
    exit 1
fi

# Assign the arguments to variables
host=$1
timeout=$2
interval=$3

# Wait till the host stops responding
while true; do
    # Ping the host
    ping -c 1 $host > /dev/null 2>&1

    # Check the exit status of the ping command
    if [ $? -eq 0 ]; then
        # Host is up, sleep for the timeout
        sleep $timeout
    else
        # Host is down, break the loop
        break
    fi
done

# Wait until host comes back up
timer=0
while true; do
    # Ping the host
    ping -c 1 $host > /dev/null 2>&1

    # Check the exit status of the ping command
    if [ $? -eq 0 ]; then
        # Host is up, break the loop
        break
    else
        # Host is down, sleep for the interval
        sleep $interval
        timer=$((timer + interval))
        if [ $timer -gt 300 ]; then
            echo "Waiting for $host to come up for too long ($timer seconds)... Exiting ungracefuly"
            exit 2
        fi
    fi
done

# Exit with status code 0

exit 0
```