# Install instructions:
# https://phoenixnap.com/kb/install-elk-stack-centos-8

include:
  - sls/elk/setup
  - sls/elk/elastic
  - sls/elk/kibana

/etc/systemd/system/logstash.service:
  file.managed:
    - source: salt://managedFiles/elk/logstash.service

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

/etc/logstash/conf.d/02-beats-input.conf:
  file.managed:
    - source: salt://managedFiles/elk/beats.conf
    - user: root
    - group: root
    - mode: 644

/etc/logstash/conf.d/10-syslog-filter.conf:
  file.managed:
    - source: salt://managedFiles/elk/filter.conf
    - user: root
    - group: root
    - mode: 644

/etc/logstash/conf.d/30-elasticsearch-output.conf:
  file.managed:
    - source: salt://managedFiles/elk/output.conf
    - user: root
    - group: root
    - mode: 644

