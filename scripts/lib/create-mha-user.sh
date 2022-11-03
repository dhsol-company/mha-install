#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/../.."

checker="/root/installation/mha-user-created"

if [ -f "$checker" ]; then
  echo "이미 mha 사용자 생성이 완료되었습니다. 다시 진행하려면 $checker 파일을 지워주세요."
  exit 0
fi

echo "mha 사용자를 생성합니다."
useradd -g mysql mha && echo "mha 사용자를 생성하였습니다." || echo "앗, 'mha' 사용자가 이미 존재하나봅니다!"

echo "mha 사용자의 비밀번호를 변경합니다."
passwd mha

echo "mha 사용자의 PATH를 변경한 .bashrc 파일을 복사합니다."
cp $rootdir/resources/system/.bashrc /home/mha/.bashrc
chown mha:mysql /home/mha/.bashrc

touch $checker