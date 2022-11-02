#!/bin/bash

# MUST be run as mha!

set -e

echo "Setting up /etc/hosts."
curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/resources/system/hosts >/etc/hosts

echo "Starting up MariaDB."
systemctl start mariadb.service

echo "Securing up MariaDB."
mysql_secure_installation </dev/tty # address terminal directly

echo "Creating users and schema."
curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/lib/mariadb-users-and-schema.sh | bash

