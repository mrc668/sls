zeek:
  user.present:
    - name: zeek
    - home: /home/zeek
    - shell: /bin/bash
    - usergroup: true
  pkg.installed:
    - pkgs:
      - zeek-lts
      - zeek-lts-core
      - zeek-lts-zkg
      - zeekctl-lts

zeek-set-perms:
  cmd.run:
    - name: /usr/local/sbin/zeek-perms
    - cwd: /
    - runas: root

