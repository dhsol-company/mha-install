#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/.."

echo "호스트 파일(/etc/hosts)을 준비합니다."
cp $rootdir/resources/system/hosts /etc/hosts

echo "MariaDB를 설치합니다."
yum -y install mariadb-server

echo "시스템에서 사용할 mha 사용자를 생성합니다."
useradd -g mysql mha && echo "mha 사용자를 생성하였습니다." || echo "앗, 'mha' 사용자가 이미 존재하나봅니다!"

echo "mha 사용자의 비밀번호를 변경합니다."
passwd mha

echo "mha 사용자가 masterha 명령을 실행할 수 있도록 PATH를 변경한 .bashrc 파일을 복사합니다."
cp $rootdir/resources/system/.bashrc /home/mha/.bashrc
chown mha:mysql /home/mha/.bashrc
