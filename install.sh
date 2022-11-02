#!/bin/bash

# Run with:
# curl https://1cdc-121-170-236-221.ngrok.io/install.sh | bash

set -e

echo "Setting up /etc/hosts."
curl https://1cdc-121-170-236-221.ngrok.io/resources/system/hosts >/etc/hosts

echo "Preinstall on db-1"
ssh db-1 sudo -- sh -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/pre.sh | bash"

echo "Preinstall on db-2"
ssh db-2 sudo -- sh -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/pre.sh | bash"

echo "Preinstall on mha"
ssh mha sudo -- sh -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/pre.sh | bash"


echo "Install on db-1"
ssh db-1 sudo -- sh -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/db-1.sh | bash"

echo "Install on db-2"
ssh db-2 sudo -- sh -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/db-2.sh | bash"

echo "Install on mha"
ssh mha sudo -- sh -c "curl https://1cdc-121-170-236-221.ngrok.io/scripts/mha.sh | bash"