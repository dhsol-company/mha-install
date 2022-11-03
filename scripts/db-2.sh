#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

echo "ssh-key를 공유합니다."
./scripts/lib/share-ssh-key.sh

echo "MariaDB를 위해 3306 포트를 열어줍니다."
firewall-cmd --zone=public --add-port=3306/tcp

echo "db-2를 위한 MariaDB 설정 파일을 적절한 위치에 가져다 놓습니다."
cp ./resources/mariadb/mariadb-server.db-2.cnf /etc/my.cnf.d/mariadb-server.cnf

echo "MariaDB를 시작합니다."
systemctl start mariadb.service

echo "MariaDB 보안 설정을 시작합니다."
mysql_secure_installation

echo "MariaDB 사용자와 스케마를 생성합니다."
./scripts/lib/mariadb-users-and-schema.sh

echo "Master DB를 바라보도록 구성합니다."
./scripts/lib/follow-db-1.sh

