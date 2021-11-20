
logstash:
  pkg:
    - installed
  service.running: 
    - name: logstash
    - enable: true
    - watch:
      - file: /etc/logstash/conf.d/*
  user.present:
    - fullname: logstash service user
    - shell: /sbin/nologin
    - home: /usr/share/logstash
    - groups:
      - logstash

/etc/logstash/conf.d:
  file.recurse:
    - source: salt://sls/elk/logstash.d
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

/etc/systemd/system/logstash.service:
  file.managed:
    - source: salt://sls/elk/logstash.service

