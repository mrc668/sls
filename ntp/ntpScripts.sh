#!/bin/bash
# source salt://sls/ntp/ntpScripts.sh

# cmds run on Cent 7 hosts (with ntp).
/usr/bin/systemctl enable ntpd
[ -f /usr/lib/systemd/system/chronyd.service ] && /usr/bin/systemctl disable chronyd
exit 0



