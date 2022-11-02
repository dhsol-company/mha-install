#!/bin/bash

set -e

echo "Setting up /etc/hosts."
curl http://cloud.potados.com:8272/mha-install/resources/system/hosts >/etc/hosts

echo "Installing MariaDB. This may take a while."
yum -y install mariadb-server

echo "Creating system mha user."
read -p "Enter password for system user 'mha': " mha_password </dev/tty # address terminal directly
useradd -g mysql mha
echo "mha:$mha_password" | chpasswd

echo "Adding to PATH."
echo "export PATH=$PATH:/usr/local/bin:/usr/local/mysql/bin" >>~/.bash_profile
source ~/.bash_profile