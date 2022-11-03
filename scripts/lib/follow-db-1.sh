#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

echo "이 DB를 slave로 구성하기 위해 db-1의 마스터 정보를 알아 옵니다."
master_log_file=$(mysql --host=db-1 --user=mha --password=mha -Ne "show master status\G" | head -n 2 | tail -n 1)
master_log_pos=$(mysql --host=db-1 --user=mha --password=mha -Ne "show master status\G" | head -n 3 | tail -n 1)

echo "Slave를 시작합니다."
mysql -e "change master to master_host='db-1', master_user='repl', master_password='repl', master_log_file='$master_log_file', master_log_pos=$master_log_pos;"
mysql -e "start slave;"
mysql -e "show slave status\G;"