#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

basedir=$(dirname "$(readlink -f "$0")")
rootdir="$basedir/../.."

slave_host=$1
master_host=$2

if [ -z "$slave_host" ] || [ -z "$master_host" ]; then
  echo "첫 번째 인자는 slave의 호스트, 두 번째 인자는 master의 호스트가 필요합니다!"
  exit 1;
fi

echo "이 DB를 slave로 구성하기 위해 db-1의 마스터 정보를 알아 옵니다."
master_log_file=$(mysql --host=$master_host --user=mha --password=mha -Ne "show master status\G" | head -n 2 | tail -n 1)
master_log_pos=$(mysql --host=$master_host --user=mha --password=mha -Ne "show master status\G" | head -n 3 | tail -n 1)

echo "Slave를 시작합니다."
mysql --host=$slave_host --user=mha --password=mha -e "stop slave;"
mysql --host=$slave_host --user=mha --password=mha -e "change master to master_host='$master_host', master_user='repl', master_password='repl', master_log_file='$master_log_file', master_log_pos=$master_log_pos;"
mysql --host=$slave_host --user=mha --password=mha -e "start slave;"
mysql --host=$slave_host --user=mha --password=mha -e "show slave status\G;"