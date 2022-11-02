#!/bin/bash

# MUST be run as root!

set -e

echo "Copy mha user's ssh key to all hosts."
su - mha -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/lib/share-ssh-keys.sh | bash"

echo "db-1 setup done!"