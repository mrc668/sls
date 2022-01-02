
filebeat:
  pkg:
    - installed
    - name: filebeat
  service.running:
    - enable: true
    - watch:
      - file: /etc/filebeat/filebeat.yml
      - file: /etc/filebeat/modules.d/*.yml
      - pkg: filebeat

/etc/filebeat/filebeat.yml:
  file.managed:
    - source: salt://sls/beats/filebeat.yml.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja

{% for d in [ "activemq", "apache", "auditd", "awsfargate", "aws", "azure", "barracuda", "bluecoat", "cef", "checkpoint", "cisco", "coredns", "crowdstrike", "cyberarkpas", "cyberark", "cylance", "elasticsearch", "envoyproxy", "f5", "fortinet", "gcp", "googlecloud", "google_workspace", "gsuite", "haproxy", "ibmmq", "icinga", "iis", "imperva", "infoblox", "iptables", "juniper", "kafka", "kibana", "logstash", "microsoft", "misp", "mongodb", "mssql", "mysqlenterprise", "mysql", "nats", "netflow", "netscout", "nginx", "o365", "okta", "oracle", "osquery", "panw", "pensando", "postgresql", "proofpoint", "rabbitmq", "radware", "redis", "santa", "snort", "snyk", "sonicwall", "sophos", "squid", "suricata", "system", "threatintel", "tomcat", "traefik", "zeek", "zookeeper", "zoom", "zscaler" ] %}
/etc/filebeat/modules.d/{{d}}.yml.disabled:
  file.absent
{% endfor %}

{% for m in [ "system", "iptables" ] %}
/etc/filebeat/modules.d/{{m}}.yml:
  file.managed:
    - source: salt://sls/beats/filebeatModules/{{m}}.yml
    - user: root
    - group: root
    - mode: 644
{% endfor %}

{% for m in grains["fileBeats"]  %}
/etc/filebeat/modules.d/{{m}}.yml:
  file.managed:
    - source: salt://sls/beats/filebeatModules/{{m}}.yml
    - user: root
    - group: root
    - mode: 644
{% endfor %}

/usr/lib/systemd/system/filebeat.service:
  file.managed:
    - source: salt://sls/beats/filebeat.service
    - user: root
    - group: root
    - mode: 644

zeekConnLong:
  file.recurse:
    - source: salt://sls/beats/filebeatZeekConnLong
    - name: /usr/share/filebeat/module/zeek/conn_long
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755

