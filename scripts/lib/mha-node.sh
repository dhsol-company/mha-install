#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

echo "패키지 디렉토리를 마련합니다."
mkdir -p /root/pkg
cd /root/pkg

echo "패키지를 내려받습니다."
wget https://github.com/dhsol-company/mha4mysql-node/releases/download/v0.58-fix/mha4mysql-node-0.58-fix.tar.gz

echo "압축을 해제합니다."
tar xzfv mha4mysql-node-0.58-fix.tar.gz
cd mha4mysql-node-0.58-fix

echo "Makefile을 실행합니다"
perl Makefile.PL

echo "make를 실행합니다."
make
make install
