#!/bin/bash
# source: salt://sls/openvpn/bin

env | sort > /dev/shm/$(basename $0).env
echo $* >  /dev/shm/$(basename $0).cli
passedFile="$1"

# prepare the password file
sed -e 's/\(.*\)/\L\1/' -i $passedFile
vpnuser=$(head -1 $passedFile )
sed -e "1s/^/username = /; 2s/^/password = /;" -i $passedFile

echo $vpnuser  $common_name  $trusted_ip $untrusted_ip $ifconfig_pool_local_ip | logger -p daemon.info -t openvpnAuth

# Tie login to cert. login should be embedded iin cert.
echo $common_name | grep $vpnuser -q || {
  logger daemon.info -t openvpnAuth login name does not match common name on certificate
  exit 2
}

# Not sure what this does
#[ -f $CWD/authVars ] && . $PWD/authUser.vars

# Not sure what this does
#grep $vpnuser $PWD/userCerts | grep $common_name -q || exit 1

smbclient -A $passedFile -L //192.168.0.6/ >/dev/null 2>&1 && exit 0

cat $passedFile | logger -p daemon.info -t openvpnAuth

exit 1

