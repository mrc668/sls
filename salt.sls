/etc/cron.d/salt:
  file.managed:
    - source: salt://managedFiles/cron.d.salt
    - user: root
    - group: root
    - mode: 644

/etc/logrotate.d/salt:
  file.managed:
    - source: salt://managedFiles/logrotate-salt
    - user: root
    - group: root
    - mode: 644



