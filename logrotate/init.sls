logrotate:
  pkg:
    - installed
  
/etc/cron.daily/logrotate:
  file.managed:
    - source: salt://logrotate/cron
    - user: root
    - group: root
    - mode: 755

/etc/logrotate.conf:
  file.managed:
    - source: salt://logrotate/logrotate.conf
    - user: root
    - group: root
    - mode: 644

/etc/logrotate.d/wtmp:
  file.managed:
    - source: salt://logrotate/wtmp
    - user: root
    - group: root
    - mode: 644



