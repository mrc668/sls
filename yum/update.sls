include:
  - yum

run_yum_daily:
  cmd.run:
    - name: /usr/local/sbin/yum.daily
    - runas: root
    - bg: True
    - onlyif: test -f /usr/local/sbin/yum.daily
