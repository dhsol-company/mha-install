#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/../.."

checker="/root/installation/db-secured"

if [ -f "$checker" ]; then
  echo "이미 DB 보안 설정이 완료되었습니다. 다시 진행하려면 $checker 파일을 지워주세요."
  exit 0
fi

echo "mysql_secure_installation을 실행합니다."
mysql_secure_installation

touch $checker
