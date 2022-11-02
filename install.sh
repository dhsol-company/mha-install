#!/bin/bash

# Run with:
# curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/install.sh | bash

set -e

echo "Setting up /etc/hosts."
curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/resources/system/hosts >/etc/hosts

echo "Preinstall on db-1"
ssh db-1 sudo -- sh -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/pre.sh | bash"

echo "Preinstall on db-2"
ssh db-2 sudo -- sh -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/pre.sh | bash"

echo "Preinstall on mha"
ssh mha sudo -- sh -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/pre.sh | bash"


echo "Install on db-1"
ssh db-1 sudo -- sh -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/db-1.sh | bash"

echo "Install on db-2"
ssh db-2 sudo -- sh -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/db-2.sh | bash"

echo "Install on mha"
ssh mha sudo -- sh -c "curl https://raw.githubusercontent.com/dhsol-company/mha-install/main/scripts/mha.sh | bash"