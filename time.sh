#!/usr/bin/bash

current_unix_time=$(date +%s)
echo "Current UNIX time (64-bit): $current_unix_time"

# Assuming the current time is within the 32-bit range for demonstration
current_unix_time_32=$(($current_unix_time & 0xFFFFFFFF))
echo "Current UNIX time (32-bit): $current_unix_time_32"

# Convert 64-bit UNIX time to human-readable
echo "64-bit Time: $(date -d @"$current_unix_time")"

# Convert 32-bit UNIX time to human-readable (within 32-bit date range)
echo "32-bit Time: $(date -d @"$current_unix_time_32")"

exit 0