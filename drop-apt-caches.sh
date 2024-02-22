#!/bin/bash

# Dropping apt caches

# Logging

# Log info (info)
infomessage="INFO   Initializing APT dropping script"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="INFO   Root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# First, removing unnecessary packages

# Log info (info)
infomessage="INFO   Performing apt-get autoremove"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

apt-get autoremove

if [[ "$?" -ne "0" ]]
then
    # Log error (err)
    errormessage="ERROR  apt-get autoremove failed"
    logmessage="ERROR  $(echo \"$errormessage\")"
    echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
    exit 1
fi

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="INFO   After apt-get autoremove, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Dropping package archives

# Log info (info)
infomessage="INFO   Performing apt-get clean"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

apt-get clean

if [[ "$?" -ne "0" ]]
then
    # Log error (err)
    errormessage="ERROR  apt-get clean failed"
    logmessage="ERROR  $(echo \"$errormessage\")"
    echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
    exit 1
fi

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="INFO   After apt-get clean, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Dropping lists

# Log info (info)
infomessage="INFO   Dropping lists"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

rm -rf /var/lib/apt/lists/*

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="INFO   After removing APT lists, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Regenerating lists
# Disabling this - will be generating lists before each installation

# Log info (info)
# infomessage="INFO   Regenerating lists"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# apt-get update

# if [[ "$?" -ne "0" ]]
# then
#     # Log error (err)
#     errormessage="ERROR  apt-get update failed"
#     logmessage="ERROR  $(echo \"$errormessage\")"
#     echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
#     exit 1
# fi

# rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
# infomessage="INFO   After regenerating APT lists, root FS has $rootfreespace MiB of disk space available"
# logmessage="INFO   $(echo \"$infomessage\")"
# echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Removing temp/incomplete packages

# Log info (info)
infomessage="INFO   Performing apt-get autoclean"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

apt-get autoclean

if [[ "$?" -ne "0" ]]
then
    # Log error (err)
    errormessage="ERROR  apt-get autoclean failed"
    logmessage="ERROR  $(echo \"$errormessage\")"
    echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
    exit 1
fi

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="INFO   After apt-get autoclean, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Log info (info)
infomessage="INFO   All done"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

exit 0