#!/bin/bash

set -e

echo "한글 히히!"
echo "This is a preinstall script."
echo "Please run this on all servers including manager server."

name=$(hostname)

if [[ $name == *DB-1 ]]; then
  sudo ./scripts/pre.sh
elif [[ $name == *DB-2 ]]; then
  sudo ./scripts/pre.sh
elif [[ $name == *MHA ]]; then
  sudo ./scripts/pre.sh
else
  echo "Unknown host name. Aborting installation."
fi
