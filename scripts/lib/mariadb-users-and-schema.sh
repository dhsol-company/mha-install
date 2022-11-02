#!/bin/bash

# MUST be run as root!

set -e

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
