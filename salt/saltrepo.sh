#!/bin/bash
# source: salt://sls/salt/saltrepo.sh

doTheWork() {
  # Get version number
  Major=0
  grep " 8" /etc/redhat-release -q && Major=8
  grep " 7" /etc/redhat-release -q && Major=7

  # update
  yum -y update salt salt-minion salt-master > /var/log/yum-update-salt.log 2>&1

  grep Springdale /etc/redhat-release -q && {
    grep "Springdale Open Enterprise" /usr/lib/python3.6/site-packages/salt/grains/core.py -q || {
      sed -e '/^_OS_FAMILY_MAP/a "Springdale Open Enterprise": "RedHat",' -i /usr/lib/python3.6/site-packages/salt/grains/core.py
      systemctl restart salt-minion
    }
  }
}

doTheWork

