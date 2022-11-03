#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

echo "패키지 디렉토리를 마련합니다."
mkdir -p /root/pkg
cd /root/pkg

echo "패키지를 내려받습니다."
wget https://github.com/dhsol-company/mha4mysql-manager/releases/download/v0.58-fix/mha4mysql-manager-0.58-fix.tar.gz

echo "압축을 해제합니다."
tar xzfv mha4mysql-manager-0.58-fix.tar.gz
cd mha4mysql-manager-0.58-fix

echo "Makefile을 실행합니다"
perl Makefile.PL

echo "make를 실행합니다."
make
make install
cd ..

echo "매니저용 MHA 디렉토리를 마련합니다."
mkdir -p /etc/masterha
mkdir -p /masterha/rms
mkdir -p /masterha/scripts

echo "설정 및 스크립트를 복사합니다."
cp ./resources/mha/configs/* /etc/masterha/
cp ./resources/mha/scripts/* /masterha/scripts/

echo "디렉토리와 파일들을 mha 사용자의 것으로 만들어줍니다."
chown -R mha:mysql /masterha
