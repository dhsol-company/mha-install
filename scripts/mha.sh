#!/bin/bash

# MUST be run as root!

set -e

echo "Copy mha user's ssh key to all hosts."
su - mha -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/lib/share-ssh-keys.sh | bash"

echo "mha setup done!"