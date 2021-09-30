{% set definedRole = salt['grains.filter_by']({
    'default': {'src': 'repo' },
  }, 
    default='default',
    grain='localhost'
  ) 
%}

zeek.dependancies: 
  pkg.installed:
    - pkgs:
      - nmon
      - jq

# Install instructions:
# https://phoenixnap.com/kb/install-elk-stack-centos-8

/etc/yum.repos.d/elk.repo:
  file.managed:
    - source: salt://managedFiles/elk/{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644

/etc/profile.d/elk.sh:
  file.managed:
    - source: salt://managedFiles/elk/elk-profile.sh
    - user: root
    - group: root
    - mode: 644

{% set definedOS = salt['grains.filter_by']({
    'default': {'pkgname': 'elasticsearch', 'svcname': 'elasticsearch' },
  }, 
    default='default',
    grain='os'
  ) 
%}

elasticsearch:
  pkg:
    - installed
  service.running: 
    - name: {{definedOS.svcname}}
    - enable: true
    - watch:
      - file: /etc/elasticsearch/elasticsearch.yml

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://managedFiles/elk/elasticsearch.yml
    - user: root
    - group: root
    - mode: 644

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
    - home: /home/kibana
    - groups:
      - kibana

/etc/kibana/kibana.yml:
  file.managed:
    - source: salt://managedFiles/elk/kibana.yml
    - user: root
    - group: root
    - mode: 644

/var/log/kibana:
  file.directory:
    - user: kibana
    - group: kibana
    - mode: 755

/etc/logrotate.d/kibana.conf:
  file.managed:
    - source: salt://managedFiles/elk/logrotate
    - user: root
    - group: root
    - mode: 644

openjdk:
  pkg:
     - installed
     - name: java-1.8.0-openjdk

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

