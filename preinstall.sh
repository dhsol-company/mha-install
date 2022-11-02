#!/bin/bash

set -e

echo "This is a preinstall script."
echo "Please run this on all servers including manager server."

echo "Installing MariaDB. This may take a while."
yum -y install mariadb-server

echo "MariaDB is installed and 'mysql' user is created."
echo "Now we will create a user that will be used for all MHA operations."

echo "Creating system mha user."
read -p "Enter password for system user 'mha': " mha_password </dev/tty # address terminal directly
useradd -g mysql mha
echo "mha:$mha_password" | chpasswd

echo "MHA user is created."
echo "Now futher settings will be followed."

echo "Setting up system mha user."
su - mha -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/lib/mha-user.sh | bash"

echo "Setting up /etc/hosts."
curl https://1cdc-121-170-236-221.ngrok.io/resources/system/hosts >/etc/hosts



