#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/.."

echo "ssh-key를 공유합니다."
$rootdir/scripts/lib/share-ssh-key.sh

echo "MHA를 위한 의존성을 설치합니다."
$rootdir/scripts/lib/dependencies.sh

echo "MHA 노드를 설치합니다."
$rootdir/scripts/lib/mha-node.sh

