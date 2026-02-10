chrony:
  pkg:
    - installed
  service.running: 
    - name: chronyd
    - enable: true
    - watch:
      - file: /etc/chrony.conf
  user.present:
    - home: /var/lib/chrony
    - shell: /sbin/nologin

{% set definedRole = salt['grains.filter_by']({
    'empty': {'conf': 'sls/ntp/chrony.conf', 'clef': 'sls/ntp/chrony.keys' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

{% if grains.chrony != '' %}
  {% set conf_file=grains.chrony %}
{% else %}
  {% set conf_file="eotn" %}
{% endif %}


/etc/chrony.conf:
  file.managed:
    - source: salt://sls/ntp/chrony.conf.{{conf_file}}
    - user: chrony
    - group: chrony
    - mode: 644

/etc/chrony.keys:
  file.managed:
    - source: salt://{{definedRole.clef}}
    - user: chrony
    - group: chrony
    - mode: 644

/etc/zabbix/zabbix_agentd.d/userparameter_chrony.conf:
  file.managed:
    - source: salt://sls/ntp/userparameter_chrony.conf
    - user: root
    - group: root
    - mode: 644

/usr/local/sbin/zg-chrony-pid:
  file.managed:
    - source: salt://sls/ntp/zg-chrony-pid
    - user: root
    - group: root
    - mode: 755

/usr/bin/systemctl enable chronyd:
  cmd.run

