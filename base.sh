#!/usr/bin/bash
# Basic tools and initial script after the installation (Debian 12)

echo "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual." | sudo tee /etc/apt/sources.list \
&& echo "/etc/apt/sources.list updated" || echo "Failed to update /etc/apt/sources.list" && exit 1

apt update && echo "APT updated" || echo "Failed to update apt" && exit 2

apt -y install apt-transport-https && echo "apt-transport-https installed" || echo "Failed to install apt-transport-https" && exit 3

apt -y upgrade && echo "System upgraded" || echo "Failed to upgrade apt" && exit 4

apt -y install nano pigz zip unzip net-tools git wget curl && echo "Basic tools installed" || echo "Failed to install basic tools" && exit 5

read -p "The system will reboot. Press ENTER"

reboot &

exit 0