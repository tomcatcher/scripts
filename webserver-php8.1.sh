#!/usr/bin/bash
# Install apache2, php8.1, and set everything up for PrestaShop 8.1.0

echo "deb https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php.list && echo "Repo list writen" \
        || exit 1
apt -y install lsb-release ca-certificates curl wget gnupg2 > /dev/null 2>&1 && \
        echo "Prerequisites installed" || exit 2
wget -qO- https://packages.sury.org/php/apt.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/sury-php-x.x.gpg && \
        echo "Key for repo set up" || && exit 3
apt update && echo "APT refreshed" || exit 3
apt -y install apache2 apache2-bin apache2-data apache2-doc apache2-utils fontconfig-config fonts-dejavu-core \
               iptraf-ng iso-codes iucode-tool lsb-release make php-common php8.1 php8.1-cli \
               php8.1-common php8.1-curl php8.1-gd php8.1-intl php8.1-mbstring php8.1-mysql php8.1-opcache \
               php8.1-readline php8.1-xml php8.1-zip && echo "Packages installed" || exit 4
echo "Apache site configuration will open for editing once You press ENTER"
read
nano /etc/apache2/sites-available/000-default.conf
# a2enmod rewrite
# a2enmod headers
systemctl restart apache2 && echo "Apache restarted" || exit 5
echo "Done, go ahead and aim Your browser at the system to install and configure PrestaShop."

exit 0