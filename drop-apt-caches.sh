#!/bin/bash

# Dropping apt caches

# Logging

# Log info (info)
infomessage="Initializing APT dropping script"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="Root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# First, removing unnecessary packages

# Log info (info)
infomessage="Performing apt-get autoremove"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

apt-get autoremove

if [[ "$?" -ne "0" ]]
then
    # Log error (err)
    errormessage="apt-get autoremove failed"
    logmessage="ERROR  $(echo \"$errormessage\")"
    echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
    echo "Failure - check the logs"
    exit 1
fi

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="After apt-get autoremove, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Dropping package archives

# Log info (info)
infomessage="Performing apt-get clean"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

apt-get clean

if [[ "$?" -ne "0" ]]
then
    # Log error (err)
    errormessage="apt-get clean failed"
    logmessage="ERROR  $(echo \"$errormessage\")"
    echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
    echo "Failure - check the logs"
    exit 1
fi

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="After apt-get clean, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Dropping lists

# Log info (info)
infomessage="Dropping lists"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

rm -rf /var/lib/apt/lists/*

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="After removing APT lists, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Removing temp/incomplete packages

# Log info (info)
infomessage="Performing apt-get autoclean"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

apt-get autoclean

if [[ "$?" -ne "0" ]]
then
    # Log error (err)
    errormessage="apt-get autoclean failed"
    logmessage="ERROR  $(echo \"$errormessage\")"
    echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "err"
    echo "Failure - check the logs"
    exit 1
fi

rootfreespace=$(df -m / | tail -1 | awk '{ print $4 }')

# Log info (info)
infomessage="After apt-get autoclean, root FS has $rootfreespace MiB of disk space available"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

# Log info (info)
infomessage="All done"
logmessage="INFO   $(echo \"$infomessage\")"
echo "$logmessage" | systemd-cat -t "apt-cache-drop" -p "info"

echo "All done! Exiting happily"
exit 0