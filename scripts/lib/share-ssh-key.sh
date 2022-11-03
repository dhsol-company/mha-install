#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/../.."

sudo -i -u mha bash << EOF
echo "여기서부터는 mha 사용자로 실행합니다."

echo "SSH key를 생성합니다."
echo "모두 Enter로 넘어가주세요 :)"
ssh-keygen -t rsa -b 4096 </dev/tty # address terminal directly

echo "만든 SSH key를 db-1 서버에 보냅니다."
echo "db-1 서버의 mha 사용자 비밀번호를 물어볼 것입니다."
ssh-copy-id mha@db-1 </dev/tty # address terminal directly

echo "만든 SSH key를 db-2 서버에 보냅니다."
echo "db-2 서버의 mha 사용자 비밀번호를 물어볼 것입니다."
ssh-copy-id mha@db-2 </dev/tty # address terminal directly

echo "만든 SSH key를 mha 서버에 보냅니다."
echo "mha 서버의 mha 사용자 비밀번호를 물어볼 것입니다."
ssh-copy-id mha@mha </dev/tty # address terminal directly

echo "mha 사용자로 실행하는 구문을 마칩니다."
EOF