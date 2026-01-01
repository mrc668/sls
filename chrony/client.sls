# client.sls
{% from "chrony/map.jinja" import cfg with context %}

chrony_package:
  pkg.installed:
    - name: chrony

chrony_client_config:
  file.managed:
    - name: /etc/chrony.conf
    - source: salt://chrony/chrony.conf.jinja
    - template: jinja
    - defaults:
        # This 'server' value comes from your map.jinja
        ntp_server: {{ cfg.server }}

chrony_service:
  service.running:
    - name: chronyd
    - enable: True
    - watch:
      - file: chrony_client_config
