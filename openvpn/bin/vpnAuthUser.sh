#!/bin/bash
# source: salt://sls/openvpn/bin

env | sort > /dev/shm/$(basename $0).env
echo $* >  /dev/shm/$(basename $0).cli
passedFile="$1"

# prepare the password file
sed -e "1s/[^a-z].*$//" -i $passedFile
sed -e 's/\(.*\)/\L\1/' -i $passedFile
vpnuser=$(head -1 $passedFile )
sed -e "1s/^/username = /; 2s/^/password = /;" -i $passedFile

# Not sure what this does
#[ -f $CWD/authVars ] && . $PWD/authUser.vars

# Not sure what this does
#grep $vpnuser $PWD/userCerts | grep $common_name -q || exit 1

echo $vpnuser  $common_name  $trusted_ip $untrusted_ip $ifconfig_pool_local_ip | logger -p daemon.info -t openvpnAuth
smbclient -A $passedFile -L //192.168.0.6/ >/dev/null 2>&1 && exit 0

exit 1

