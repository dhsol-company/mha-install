#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

echo "ssh-key를 공유합니다."
su - mha -c ./lib/share-ssh-key.sh
