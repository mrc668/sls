/etc/selinux/config:
  file.managed:
    - source: salt://sls/rootenv/selinux
    - user: root
    - group: root
    - mode: 600

/etc/profile.d/syslog.sh:
  file.managed:
    - source: salt://sls/rootenv/syslog.sh
    - user: root
    - group: root
    - mode: 644

/etc/postfix/main.cf:
  file.managed:
    - source: salt://sls/rootenv/main.cf
    - user: root
    - group: root
    - mode: 644

/etc/sudoers:
  file.managed:
    - source: salt://sls/rootenv/sudoers
    - user: root
    - group: root
    - mode: 640

pickup:
  file.managed:
    - source: salt://sls/rootenv/pickup
    - name: /usr/local/sbin/pickup
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /
    - runas: root


