#!/bin/bash

# MUST be run as root!

set -e

echo "Copy mha user's ssh key to all hosts."
su - mha -c "curl http://cloud.potados.com:8272/mha-install/scripts/lib/share-ssh-keys.sh | bash"

echo "db-2 setup done!"