#!/usr/bin/bash
# Basic tools and initial script after the installation (Debian 12)

echo "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list \
&& echo "/etc/apt/sources.list updated" || exit 1

apt update && echo "APT updated" || exit 2

apt -y install apt-transport-https && echo "apt-transport-https installed" || exit 3

apt -y upgrade && echo "System upgraded" || exit 4

apt -y install nano pigz zip unzip net-tools git wget curl && echo "Basic tools installed" || exit 5

read -p "The system will reboot. Press ENTER"

reboot &

exit 0