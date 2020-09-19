/etc/cron.d/1daily:
  file.managed:
    - source: salt://managedFiles/cron.daily
    - user: root
    - group: root
    - mode: 644

/etc/anacrontab:
  file.managed:
    - source: salt://managedFiles/anacrontab
    - user: root
    - group: root
    - mode: 644



