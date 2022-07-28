
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

{% if grains['os'] == 'Springdale Open Enterprise' %}
include:
  - sls/zabbix/libsss
{% endif %}

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://sls/zabbix/zabbix_agentd.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        zabbix_server: "10.0.10.3"
{% if grains['zabbix_server'] is defined %}
    - context:
        zabbix_server: {{ grains['zabbix_server'] }}
{% endif %}
        

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

/etc/zabbix/eotn.d:
  file.recurse:
    - name: /etc/zabbix/eotn.d
    - source: salt://personality/{{grains['nodename']}}/zabbix.eotn.conf
    - user: zabbix
    - group: zabbix
    - dir_mode: 755
    - file_mode: 644

