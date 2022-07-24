
named:
  pkg:
    - name: bind
    - installed
  service.running:
    - enable: true
    - name: named
    - watch:
      - file: /etc/named.conf

/var/named:
  file.directory:
    - user: root
    - group: named
    - mode: 1770

/var/log/named:
  file.directory:
    - user: named
    - group: named
    - mode: 770

named.standard:
  file.recurse:
    - source: salt://sls/bind/named
    - name: /etc/named
    - exclude_pat: .*.swp
    - user: named
    - group: named
    - dir_mode: 750
    - file_mode: 640

named.local:
  file.recurse:
    - source: salt://personality/{{ grains['nodename']}}/named
    - name: /etc/named
    - exclude_pat: .*.swp
    - user: named
    - group: named
    - dir_mode: 750
    - file_mode: 640

/etc/named.conf:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/named.conf
    - user: named
    - group: named
    - mode: 640

/etc/sysconfig/named:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/named.vars
    - user: named
    - group: named
    - mode: 644

/usr/sbin/named-checkconf -z /etc/named.conf:
  cmd.run:
    - cwd: /

