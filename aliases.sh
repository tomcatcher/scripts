#!/usr/bin/bash

# This file loads my aliases at the beginning of each session. It is to be placed into /etc/profile.d/aliases.sh

# Aliases
alias ll='ls -lah'

# Write the aliases to a file in /etc/profile.d/
echo "alias ll='ls -lah'" > ~/.bashrc
echo "alias ltr='ls -ltrah'" >> ~/.bashrc
echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ../..'" >> ~/.bashrc
echo "alias ....='cd ../../..'" >> ~/.bashrc
echo "alias .....='cd ../../../..'" >> ~/.bashrc

# All done, greet and exit
echo "Done! Aliases set. Log out and back in again to apply the changes."
exit 0