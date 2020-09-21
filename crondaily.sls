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


/etc/cron.daily/yum.daily:
  file.managed:
    - source: salt://managedFiles/yum.daily
    - user: root
    - group: root
    - mode: 755

/etc/logrotate.d/yum-daily.conf:
  file.managed:
    - source: salt://managedFiles/logrotate-yum.daily
    - user: root
    - group: root
    - mode: 644



