
/etc/systemd/system/efs-data.service:
  file.managed:
    - source: salt://pillars/efs/efs-data.service
    - user: root
    - group: root
    - mode: 644

/usr/bin/systemctl enable efs-data:
  cmd.run

/usr/sbin/efs:
  file.managed:
    - source: salt://pillars/efs/efs
    - user: root
    - group: root
    - mode: 755

/data:
  file.directory:
    - user: root
    - group: root
    - mode: 755

