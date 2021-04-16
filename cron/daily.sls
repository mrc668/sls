cronie-anacron:
  pkg.removed

cronie-noanacron:
  pkg:
    - installed
  service.running: 
    - name: crond
    - enable: true

/etc/cron.d/dailyjobs:
  file.managed:
    - source: salt://managedFiles/cron.run.parts
    - user: root
    - group: root
    - mode: 644

/etc/cron.d/run.parts:
  file.absent

/etc/cron.d/0hourly:
  file.absent

/etc/cron.d/1daily:
  file.absent

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



