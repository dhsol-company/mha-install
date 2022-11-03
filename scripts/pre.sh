#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/.."

mkdir -p /root/installation

echo "호스트 파일(/etc/hosts)을 준비합니다."
cp $rootdir/resources/system/hosts /etc/hosts

echo "MariaDB를 설치합니다."
yum -y install mariadb-server

echo "시스템에서 사용할 mha 사용자를 생성합니다."
$rootdir/scripts/lib/create-mha-user.sh