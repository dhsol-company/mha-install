#!/bin/bash

set -e

name=$(hostname)

if [[ $name == *DB-1 ]]; then
  sudo -- sh -c "curl http://rms.dhsc.co.kr/mha/scripts/install-db-1.sh | bash"
elif [[ $name == *DB-2 ]]; then
  sudo -- sh -c "curl http://rms.dhsc.co.kr/mha/scripts/install-db-2.sh | bash"
elif [[ $name == *MHA ]]; then
  sudo -- sh -c "curl http://rms.dhsc.co.kr/mha/scripts/install-mha.sh | bash"
else
  echo "Unknown host name. Aborting installation."
fi
