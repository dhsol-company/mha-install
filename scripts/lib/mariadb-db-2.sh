#!/bin/bash

# MUST be run as root!

set -e

echo "Installing MariaDB. This may take a while."
yum -y install mariadb-server

echo "Starting up MariaDB."
systemctl start mariadb.service

echo "Setting up MariaDB."
mysql_secure_installation </dev/tty # address terminal directly

echo "Creating DB user."
read -p "Enter password for DB user 'MES_DHSol': " mes_dhsol_password </dev/tty # address terminal directly
mysql -e "create user 'MES_DHSol'@'%' identified by '$mes_dhsol_password';"

echo "Creating rms_ulsan database."
mysql -e "create database rms_ulsan"
mysql -e "grant all privileges on rms_ulsan.* to 'MES_DHSol'@'%';"

echo "Creating rms_gyeongju database."
mysql -e "create database rms_gyeongju;"
mysql -e "grant all privileges on rms_gyeongju.* to 'MES_DHSol'@'%';"

echo "Creating rms_document database."
mysql -e "create database rms_document;"
mysql -e "grant all privileges on rms_document.* to 'MES_DHSol'@'%';"

echo "Creating repl user."
mysql -e "create user 'repl'@'210.183.205.0/255.255.255.0' identified by 'repl';"
mysql -e "grant replication slave on *.* to 'repl'@'210.183.205.0/255.255.255.0';"

echo "Creating mha user."
mysql -e "create user 'mha'@'210.183.205.0/255.255.255.0' identified by 'mha';"
mysql -e "grant all privileges on *.* to 'mha'@'210.183.205.0/255.255.255.0';"

echo "Setting up mariadb-server.cnf"
curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/resources/mariadb/mariadb-server.db-2.cnf >/etc/my.cnf.d/mariadb-server.cnf

echo "Allowing tcp access on 3306 port."
firewall-cmd --zone=public --add-port=3306/tcp

echo "Restarting MariaDB"
systemctl restart mariadb

echo "Collecting master log status."
master_log_file=$(mysql --host=db-1 --user=mha --password=mha -Ne "show master status\G" | head -n 2 | tail -n 1)
master_log_pos=$(mysql --host=db-1 --user=mha --password=mha -Ne "show master status\G" | head -n 3 | tail -n 1)

echo "Starting slave."
mysql -e "change master to master_host='db-1', master_user='repl', master_password='repl', master_log_file='$master_log_file', master_log_pos=$master_log_pos;"
mysql -e "start slave;"
mysql -e "show slave status\G;"