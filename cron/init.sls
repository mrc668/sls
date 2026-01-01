cronie-anacron:
  pkg.removed

cronie-noanacron:
  pkg:
    - installed
  service.running: 
    - name: crond
    - enable: true

/etc/cron.d/run.parts:
  file.absent

/etc/cron.d/0hourly:
  file.absent

/etc/cron.d/1daily:
  file.absent

/etc/anacrontab:
  file.absent

/etc/cron.d/dailyjobs:
  file.managed:
    - source: salt://cron/dailyjobs
    - user: root
    - group: root
    - mode: 644

