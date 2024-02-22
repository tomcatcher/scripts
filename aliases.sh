#!/usr/bin/bash

# This file loads my aliases at the beginning of each session. It is to be placed into /etc/profile.d/aliases.sh

# Aliases

# Write the aliases to a file in /etc/profile.d/
echo "alias ll='ls -lah'" > /etc/profile.d/aliases.sh
echo "alias ltr='ls -ltrah'" >> /etc/profile.d/aliases.sh
echo "alias ..='cd ..'" >> /etc/profile.d/aliases.sh
echo "alias ...='cd ../..'" >> /etc/profile.d/aliases.sh
echo "alias ....='cd ../../..'" >> /etc/profile.d/aliases.sh
echo "alias .....='cd ../../../..'" >> /etc/profile.d/aliases.sh

#, and source the file
source /etc/profile.d/aliases.sh

# All done, greet and exit
echo "Done!"