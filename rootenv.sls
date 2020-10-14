/root/.vimrc:
  file.managed:
    - source: salt://managedFiles/vimrc
    - user: root
    - group: root
    - mode: 600

/root/.bashrc:
  file.managed:
    - source: salt://managedFiles/bashrc
    - user: root
    - group: root
    - mode: 600

/root/.bash_profile:
  file.managed:
    - source: salt://managedFiles/bash_profile
    - user: root
    - group: root
    - mode: 600

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


