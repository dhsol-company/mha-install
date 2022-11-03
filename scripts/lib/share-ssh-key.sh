#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

sudo -i -u mha bash << EOF
echo "SSH key를 생성합니다."
echo "모두 Enter로 넘어가주세요 :)"
ssh-keygen -t rsa -b 4096

echo "만든 SSH key를 db-1 서버에 보냅니다."
echo "mha 서버의 mha 사용자 비밀번호를 물어볼 것입니다."
ssh-copy-id mha@db-1

echo "만든 SSH key를 db-1 서버에 보냅니다."
echo "mha 서버의 mha 사용자 비밀번호를 물어볼 것입니다."
ssh-copy-id mha@db-2

echo "만든 SSH key를 mha 서버에 보냅니다."
echo "mha 서버의 mha 사용자 비밀번호를 물어볼 것입니다."
ssh-copy-id mha@mha
EOF