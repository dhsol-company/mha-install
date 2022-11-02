#!/bin/bash

set -e

# 이 스크립트는 root로 실행해야 합니다!

echo "호스트 파일(/etc/hosts)을 준비합니다."
cp resources/system/hosts /etc/hosts

echo "MariaDB를 설치합니다."
# yum -y install mariadb-server

echo "시스템에서 사용할 mha 사용자를 생성합니다."
useradd -g mysql mha

read -p "'mha' 사용자에 사용할 비밀번호를 적어 주세요: " mha_password
echo "mha:$mha_password" | chpasswd

echo "'mha' 사용자가 준비되었습니다."
