#!/usr/bin/bash

echo "export PROMPT_COMMAND=\"history -a; history -c; history -r; $PROMPT_COMMAND\"" >> ~/.bashrc
echo "export HISTSIZE=1000000" >> ~/.bashrc
echo "export HISTFILESIZE=2000000000" >> ~/.bashrc
echo "export HISTTIMEFORMAT='%F %T '" >> ~/.bashrc
echo "export HISTCONTROL=ignoreboth" >> ~/.bashrc
echo "shopt -s histappend" >> ~/.bashrc
echo "shopt -s cmdhist" >> ~/.bashrc
echo "shopt -s lithist" >> ~/.bashrc
echo "shopt -s histreedit" >> ~/.bashrc
echo "shopt -s histverify" >> ~/.bashrc

source ~/.bashrc

exit 0