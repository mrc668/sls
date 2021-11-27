
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
    - source: salt://sls/elk/filebeat.yml
    - user: root
    - group: root
    - mode: 644

{% for m in [ "auditd", "system", "iptables" ] %}
/etc/filebeat/modules.d/{{m}}.yml:
  file.managed:
    - source: salt://sls/elk/filebeatModules/{{m}}.yml
    - user: root
    - group: root
    - mode: 644
{% endfor %}

{% if grains["fileBeats"] is defined %}
  {% for m in grains["fileBeats"]  %}
/etc/filebeat/modules.d/{{m}}.yml:
  file.managed:
    - source: salt://sls/elk/filebeatModules/{{m}}.yml
    - user: root
    - group: root
    - mode: 644
  {% endfor %}
{% endif %}

