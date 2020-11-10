zabbix-release:
  pkg:
    - installed
    - name: zabbix-release
    - source: salt:/managedFiles/zabbix-release-4.0-1.el7.noarch.rpm

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
    'empty': {'src': 'managedFiles/zabbix_agentd.conf' },
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


