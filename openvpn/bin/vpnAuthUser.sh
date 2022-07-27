#!/bin/bash

env | sort > /dev/shm/$(basename $0).env
echo $* >  /dev/shm/$(basename $0).cli

vpnuser=$(head -1 $1 | tr "A-Z" "a-z" | sed -e "s/[^a-z]//")
sed -e "1s/^/username = /; 2s/^/password = /;" -i $1
[ -f $PWD/authVars ] && . $PWD/authUser.vars

grep $vpnuser $PWD/userCerts | grep $common_name -q || exit 1

echo $vpnuser  $common_name  $trusted_ip $untrusted_ip $ifconfig_pool_local_ip | logger -pi daemon.info -t openvpnAuth
smbclient -A ovtemp -L //backup/ >/dev/null && exit 0

exit 1

