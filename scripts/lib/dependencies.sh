#!/bin/bash

# 이 스크립트는 root 사용자로 실행해야 합니다!

set -e

echo "CRB 저장소를 켭니다."
yum config-manager --set-enabled crb

echo "엔터프라이즈 리눅스를 위한 추가 패키지를 설치합니다."
yum install -y \
  epel-release \
  epel-next-release

echo "시스템에 도움이 되는 유틸리티를 설치합니다."
yum install -y \
  sysstat \
  lrzsz \
  htop \
  iftop

echo "MHA가 의존하는 perl 모듈을 설치합니다."
yum install -y \
  perl-CPAN \
  perl-DBD-MySQL \
  perl-Time-HiRes \
  perl-Config-Tiny \
  perl-Log-Dispatch \
  perl-Module-Install \
  perl-Parallel-ForkManager
