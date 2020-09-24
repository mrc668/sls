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
    'monitor.eotn.calnek.com': {'src': 'zabbix_agentd-monitor.conf' },
    'monitor.com': {'src': 'zabbix_agentd-monitor.conf' },
    'empty': {'src': 'zabbix_agentd.conf' },
  }, 
    default='empty',
    grain='localhost'
  ) 
%}

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://managedFiles/{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644


