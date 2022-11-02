#!/bin/bash

# Root 사용자로 실행해야 합니다!

set -e

echo "Setting up /etc/hosts"
cp /etc/hosts /etc/hosts.old
curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/ >/etc/hosts
