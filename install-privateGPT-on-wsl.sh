#!/bin/bash

# Check if user is root. If it is, tell the user it must NOT be root and exit with code 1

function check_root {
    if [ "$EUID" -eq 0 ]
    then 
        echo "You must NOT be root to run this script."
        exit 1
    fi
}

# Check if Ubuntu version is 20.04 (focal). If it is not, print "Incorrect version. Run this script only on Ubuntu 20.04 (focal).