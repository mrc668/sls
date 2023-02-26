#!/bin/bash
# source: salt://sls/openvpn/bin

env | sort > /dev/shm/$(basename $0).env
echo $* >  /dev/shm/$(basename $0).cli
passwd="/etc/openvpn/server/vpnUsers"

passedFile="$1"
vpnUser=$(head -1 $passedFile)
vpnPass=$(tail -1 $passedFile)
enc="${vpnUser}:"$(echo $vpnPass | md5sum | cut -d" " -f1)
logger -p daemon.info -t $0 $vpnUser $tls_id_0

grep $enc $passwd -q && {
  logger -p daemon.info -t $0 $vpnUser athenticated 
  exit 0
}

logger -p daemon.info -t $0 $vpnUser failed login 
logger -p daemon.info -t $0 $enc
exit 1

