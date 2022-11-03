#!/bin/bash

set -e

echo "################################################################"
echo "# 이 스크립트는 사전 설치(pre-install) 스크립트입니다."
echo "################################################################"

name=$(hostname)

mkdir -p /root/installation

if [[ $name == *DB-1 ]]; then
  echo "이 호스트는 db-1입니다. 사전 설치 작업을 시작합니다."
  echo "sudo를 사용하기 위해 현재 계정 비밀번호를 물어볼 것입니다."
  sudo ./scripts/pre.sh
elif [[ $name == *DB-2 ]]; then
  echo "이 호스트는 db-2입니다. 사전 설치 작업을 시작합니다."
  echo "sudo를 사용하기 위해 현재 계정 비밀번호를 물어볼 것입니다."
  sudo ./scripts/pre.sh
elif [[ $name == *MHA ]]; then
  echo "이 호스트는 mha입니다. 사전 설치 작업을 시작합니다."
  echo "sudo를 사용하기 위해 현재 계정 비밀번호를 물어볼 것입니다."
  sudo ./scripts/pre.sh
else
  echo "이 호스트는 ${name}입니다. 호스트를 식별할 수 없어 사전 설치 작업을 중단합니다."
  exit 1
fi

echo "################################################################"
echo "# 사전 설치(pre-install) 스크립트를 마칩니다."
echo "################################################################"
