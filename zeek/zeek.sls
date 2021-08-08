zeek:
  user.present:
    - name: zeek
    - home: /home/zeek
    - shell: /bin/bash
    - usergroup: true
  pkg:
    - name: zeek-lts
    - installed

zeek-set-perms:
  cmd.run:
    - name: /usr/local/sbin/zeek-perms
    - cwd: /
    - runas: root

