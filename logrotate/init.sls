logrotate:
  pkg:
    - installed
  
/etc/logrotate.conf:
  file.managed:
    - source: salt://sls/logrotate/logrotate.conf
    - user: root
    - group: root
    - mode: 644

/etc/logrotate.d/wtmp:
  file.managed:
    - source: salt://sls/logrotate/wtmp
    - user: root
    - group: root
    - mode: 644



