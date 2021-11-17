{% set definedRole = salt['grains.filter_by']({
    'default': {'src': 'repo', 'logstashIP': '10.0.10.135' },
  }, 
    default='default',
    grain='localhost'
  ) 
%}


filebeat:
  pkg:
    - installed
  service.running:
    - enable: true
    - watch:
      - file: /etc/filebeat/filebeat.yml
      - file: /etc/filebeat/modules.d/*

/etc/filebeat/filebeat.yml:
  file.managed:
    - source: salt://managedFiles/elk/filebeat.yml
    - user: root
    - group: root
    - mode: 644

/etc/filebeat/modules.d/system.yml:
  file.managed:
    - source: salt://managedFiles/elk/filebeatModules/system.yml
    - user: root
    - group: root
    - mode: 644

/usr/bin/filebeat setup --template -E output.logstash.enabled=true -E 'output.elasticsearch.hosts=["{{definedRole.logstashIP}}:9200"]' | tee /dev/shm/filebeat.setup.log:
  cmd.run

/usr/bin/filebeat setup -e -E output.logstash.enabled=true -E output.elasticsearch.hosts=['{{definedRole.logstashIP}}:9200'] -E setup.kibana.host={{definedRole.logstashIP}}:5601 | tee -a /dev/shm/filebeat.setup.log:
  cmd.run

/usr/bin/filebeat modules list | tee -a /dev/shm/filebeat.setup.log:
  cmd.run

/usr/local/sbin/bounce.filebeat:
  cmd.run:
    - cwd: /
  file.managed:
    - source: salt://managedFiles/elk/bounce.filebeat
    - user: root
    - group: root
    - mode: 755

