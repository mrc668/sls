/usr/local/src/salt.p1:
  file.managed:
    - source: salt://sls/salt/salt.p1
    - user: root
    - group: root
    - mode: 644

/usr/local/sbin/fixSalt.sh:
  file.managed:
    - source: salt://sls/salt/fixSalt.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /

