{% if salt['file.file_exists']('/var/log/yum-update.log') %}

/etc/logrotate.d/yum-daily.conf:
  file.managed:
    - source: salt://managedFiles/logrotate-yum.daily
    - user: root
    - group: root
    - mode: 644

{% endif %}
