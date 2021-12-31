
/etc/yum.repos.d/elk.repo:
  file.managed:
    - source: salt://sls/elk/setup/repo
    - user: root
    - group: root
    - mode: 644

/etc/profile.d/elk.sh:
  file.managed:
    - source: salt://sls/elk/setup/profile
    - user: root
    - group: root
    - mode: 644

elk.scripts:
  file.recurse:
    - source: salt://sls/elk/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755
    - dir_mode: 755

