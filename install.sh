#!/bin/bash

# Run with:
# curl http://cloud.potados.com:8272/mha-install/install.sh | bash

set -e

echo "Setting up /etc/hosts."
curl http://cloud.potados.com:8272/mha-install/resources/system/hosts >/etc/hosts

echo "Preinstall on db-1"
ssh db-1 sudo -- sh -c "curl http://cloud.potados.com:8272/mha-install/scripts/pre.sh | bash"

echo "Preinstall on db-2"
ssh db-2 sudo -- sh -c "curl http://cloud.potados.com:8272/mha-install/scripts/pre.sh | bash"

echo "Preinstall on mha"
ssh mha sudo -- sh -c "curl http://cloud.potados.com:8272/mha-install/scripts/pre.sh | bash"


echo "Install on db-1"
ssh db-1 sudo -- sh -c "curl http://cloud.potados.com:8272/mha-install/scripts/db-1.sh | bash"

echo "Install on db-2"
ssh db-2 sudo -- sh -c "curl http://cloud.potados.com:8272/mha-install/scripts/db-2.sh | bash"

echo "Install on mha"
ssh mha sudo -- sh -c "curl http://cloud.potados.com:8272/mha-install/scripts/mha.sh | bash"