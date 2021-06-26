
zabbix-agent:
  pkg:
    - installed
    - name: zabbix-agent
  service.running: 
    - enable: true
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf

{% set definedRole = salt['grains.filter_by']({
    'monitor': {'src': 'personality/monitor/zabbix_agentd.conf' },
    'empty': {'src': 'sls/zabbix/zabbix_agentd.conf' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644

/etc/zabbix/zabbix_agentd.d/enableRemoteCommands.conf:
  file.managed:
    - source: salt://sls/zabbix/enableRemoteCommands.conf
    - user: root
    - group: root
    - mode: 644

/etc/sudoers.d/zabbix:
  file.managed:
    - source: salt://sls/zabbix/sudoer
    - user: root
    - group: root
    - mode: 440

uls_zg:
  file.recurse:
    - source: salt://sls/zabbix/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755

