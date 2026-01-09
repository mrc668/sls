/usr/local/sbin/costctl:
  file.managed:
    - source: salt://salt/master/costctl.sh
    - user: root
    - group: root
    - mode: 755

