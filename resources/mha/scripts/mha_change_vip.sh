#!/bin/bash
## Fail-Over VIP Change

V_NEW_MASTER=`cat /etc/hosts | grep $1 | awk '{print $2}'`
V_EXIST_VIP_CHK=`ping -c 1 -W 1 vip | grep "packet loss" | awk '{print $6}'`
V_VIP_IP=`cat /etc/hosts | grep vip | awk '{print $1}'`

if [ $V_EXIST_VIP_CHK = "0%" ]
then
    echo "VIP is alive."

    echo "Take VIP from old master."
    ssh -o StrictHostKeyChecking=no vip /bin/sudo /sbin/ifconfig ens192:0 down &

    echo "Give VIP to new master($V_NEW_MASTER)."
    ssh -o StrictHostKeyChecking=no $V_NEW_MASTER /bin/sudo /sbin/ifconfig ens192:0 $V_VIP_IP netmask 255.255.255.0
    ssh -o StrictHostKeyChecking=no $V_NEW_MASTER /sbin/arping -c 5 -D -I ens192 -s $V_VIP_IP $V_VIP_IP

elif [ $V_EXIST_VIP_CHK = "100%" ]
then
    echo "VIP is dead."

    echo "Give VIP to new master($V_NEW_MASTER)."
    ssh -o StrictHostKeyChecking=no $V_NEW_MASTER /bin/sudo /sbin/ifconfig ens192:0 $V_VIP_IP netmask 255.255.255.0
    ssh -o StrictHostKeyChecking=no $V_NEW_MASTER /sbin/arping -c 5 -D -I ens192 -s $V_VIP_IP $V_VIP_IP
fi
