/usr/local/sbin//installZKG:
  pkg:
    - name: zeek-lts-zkg
    - installed
  file.managed:
    - source: salt://sls/zeek/installZKG
    - user: root
    - group: root
    - mode: 755
  cmd.run:
      - cwd: /root
      - runas: root

/opt/zeek/share/zeek/site/local.zeek:
  file.managed:
    - source: salt://sls/zeek/local.zeek
    - user: zeek
    - group: zeek
    - mode: 644

zkg-set-perms:
  cmd.run:
    - name: /usr/local/sbin/zeek-perms
    - cwd: /
    - runas: root

