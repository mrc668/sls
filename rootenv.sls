/etc/selinux/config:
  file.managed:
    - source: salt://managedFiles/selinux
    - user: root
    - group: root
    - mode: 600

/etc/profile.d/syslog.sh:
  file.managed:
    - source: salt://managedFiles/syslog.sh
    - user: root
    - group: root
    - mode: 644

/etc/postfix/main.cf:
  file.managed:
    - source: salt://managedFiles/main.cf
    - user: root
    - group: root
    - mode: 644


