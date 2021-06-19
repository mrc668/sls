#!/bin/bash
# source salt://sls/salt/restart-salt-minion.sh

function restart {
  sleep 3
  /usr/bin/systemctl restart salt-minion < /dev/null > /dev/null 2>&1
}
export -f restart

restart & 
disown -a
exit


#nohup bash -c restart & < /dev/null > /dev/null 2>&1
#restart & < /dev/null > /dev/null 2>&1
#restart &


