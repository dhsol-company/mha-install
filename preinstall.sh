#!/bin/bash

set -e

echo "Installing MariaDB. This may take a while."
yum -y install mariadb-server

echo "Creating system mha user."
read -p "Enter password for system user 'mha': " mha_password </dev/tty # address terminal directly
useradd -g mysql mha
echo "mha:$mha_password" | chpasswd

