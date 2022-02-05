#!/bin/bash
# source: salt://sls/salt/saltrepo.sh

doTheWork() {
  # remove competitors
  yum -y remove salt-py3-repo-3001-1.el7.noarch >/dev/null 2>&1
  rm -f /etc/yum.repos.d/salt*

  # Get version number
  Major=0
  grep " 8" /etc/redhat-release -q && Major=8
  grep " 7" /etc/redhat-release -q && Major=7

  # Get latestest repo
  curl -sS https://repo.saltproject.io/py3/redhat/$Major/x86_64/latest.repo | sed -e "/failovermethod/d" > /etc/yum.repos.d/salt.repo

  # update
  yum -y update salt salt-minion salt-master > /var/log/yum-update-salt.log 2>&1

  grep Springdale /etc/redhat-release -q && {
    grep "Springdale Open Enterprise" /usr/lib/python3.6/site-packages/salt/grains/core.py -q || {
      sed -e '/^_OS_FAMILY_MAP/a "Springdale Open Enterprise": "RedHat",' -i /usr/lib/python3.6/site-packages/salt/grains/core.py
      systemctl restart salt-minion
    }
  }
}

uname -n | grep zcs -q && doTheWork
uname -n | grep netops -q && doTheWork
uname -n | grep devil -q && doTheWork
uname -n | grep rosco -q && doTheWork
uname -n | grep pihole -q && doTheWork
uname -n | grep backup -q && doTheWork
uname -n | grep zeek -q && doTheWork
uname -n | grep siege -q && doTheWork
uname -n | grep unibase -q && doTheWork

