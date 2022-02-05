kibana:
  pkg:
    - installed
  service.running: 
    - name: kibana
    - enable: true
    - watch:
      - file: /etc/kibana/kibana.yml
  user.present:
    - fullname: kibana service user
    - shell: /sbin/nologin
    - home: /nonexistant
    - groups:
      - kibana

/etc/kibana/kibana.yml:
  file.managed:
    - source: salt://sls/elk/kibana.yml
    - user: root
    - group: root
    - mode: 644

/var/log/kibana:
  file.directory:
    - user: kibana
    - group: kibana
    - mode: 755

/etc/logrotate.d/kibana.conf:
  file.abscent

/etc/logrotate.d/kibana:
  file.managed:
    - source: salt://sls/elk/kibana.logrotate
    - user: root
    - group: root
    - mode: 644

