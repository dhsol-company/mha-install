#!/bin/bash

set -e

echo "Setting up /etc/hosts."
curl https://1cdc-121-170-236-221.ngrok.io/resources/system/hosts >/etc/hosts

echo "Installing MariaDB. This may take a while."
# yum -y install mariadb-server

echo "Creating system mha user."
read -p "Enter password for system user 'mha': " mha_password
useradd -g mysql mha
echo "mha:$mha_password" | chpasswd
