
elasticsearch:
  pkg:
    - installed
  service.running: 
    - name: elasticsearch
    - enable: true
    - watch:
      - file: /etc/elasticsearch/elasticsearch.yml

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://sls/elk/elasticsearch.yml
    - user: root
    - group: root
    - mode: 644

