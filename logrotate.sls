logrotate:
  pkg:
    - installed
  
/etc/logrotate.conf:
  file.managed:
    - source: salt://managedFiles/logrotate.conf
    - user: root
    - group: root
    - mode: 644


