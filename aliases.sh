#!/usr/bin/bash

# This file loads my aliases at the beginning of each session. It is to be placed into /etc/profile.d/aliases.sh

# Aliases

# First, apply the aliases on the fly
export alias ll='ls -lah'
export alias ltr='ls -ltrah'
export alias ..='cd ..'
export alias ...='cd ../..'
export alias ....='cd ../../..'
export alias .....='cd ../../../..'

# Write the aliases to a file in /etc/profile.d/
echo "export alias ll='ls -lah'" > /etc/profile.d/aliases.sh
echo "export alias ltr='ls -ltrah'" >> /etc/profile.d/aliases.sh
echo "export alias ..='cd ..'" >> /etc/profile.d/aliases.sh
echo "export alias ...='cd ../..'" >> /etc/profile.d/aliases.sh
echo "export alias ....='cd ../../..'" >> /etc/profile.d/aliases.sh
echo "export alias .....='cd ../../../..'" >> /etc/profile.d/aliases.sh

# All done, greet and exit
echo "Done!"