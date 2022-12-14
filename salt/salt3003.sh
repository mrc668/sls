#!/bin/bash
# source: salt://sls/salt/salt3003.sh

rpm -q salt-minion | grep 3003 -q && exit

curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/3003.repo > /etc/yum.repos.d/salt3003.repo
for i in salt-py3-3001.repo salt.repo; do
  [ -f $i ] && sed -e "s/enabled=1/enabled=0/" -i $i
done

systemctl stop salt-minion >/dev/null
yum -y update salt-minion > /var/log/yum.update.salt-minion 2>&1
systemctl start salt-minion >/dev/null 2>&1

yum -y remove salt-py3-repo-3001-1.el7.noarch


