#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/../.."

checker="/root/installation/schema-and-user-created"

if [ -f "$checker" ]; then
  echo "이미 DB 사용자와 스케마 생성이 완료되었습니다. 다시 진행하려면 $checker 파일을 지워주세요."
  exit 0
fi

echo "서비스용 DB 사용자(MES_DHSol)를 생성합니다."
read -p "DB 사용자 'MES_DHSol'의 비밀번호는 무엇으로 할까요?: " mes_dhsol_password
mysql -e "create user 'MES_DHSol'@'%' identified by '$mes_dhsol_password';"

echo "rms_ulsan 데이터베이스를 생성합니다."
mysql -e "create database rms_ulsan"
mysql -e "grant all privileges on rms_ulsan.* to 'MES_DHSol'@'%';"

echo "rms_gyeongju 데이터베이스를 생성합니다."
mysql -e "create database rms_gyeongju;"
mysql -e "grant all privileges on rms_gyeongju.* to 'MES_DHSol'@'%';"

echo "rms_document 데이터베이스를 생성합니다."
mysql -e "create database rms_document;"
mysql -e "grant all privileges on rms_document.* to 'MES_DHSol'@'%';"

echo "복제용 DB 사용자(repl)를 생성합니다. 내부 망에서만 접근 가능합니다."
mysql -e "create user 'repl'@'210.183.205.0/255.255.255.0' identified by 'repl';"
mysql -e "grant replication slave on *.* to 'repl'@'210.183.205.0/255.255.255.0';"

echo "MHA용 DB 사용자(mha)를 생성합니다. 내부 망에서만 접근 가능합니다."
mysql -e "create user 'mha'@'210.183.205.0/255.255.255.0' identified by 'mha';"
mysql -e "grant all privileges on *.* to 'mha'@'210.183.205.0/255.255.255.0';"

touch $checker