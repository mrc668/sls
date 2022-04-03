
named:
  pkg:
    - name: bind
    - installed
  service.running:
    - enable: true
    - named: named
    - watch:
      - file: /etc/named.conf

/etc/named:
  file.recurse:
    - source: salt://pillars/bind/named
    - user: named
    - group: named
    - dir_mode: 750
    - file_mode: 640

/etc/named.local:
  file.recurse:
    - source: salt://personality/{{ grains['nodename']}}/named
    - user: named
    - group: named
    - dir_mode: 750
    - file_mode: 640

/etc/named.conf:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/named.conf
    - user: named
    - group: named
    - file: 640

/etc/sysconfig/named:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/named.vars
    - user: named
    - group: named
    - file: 644

/usr/sbin/named-checkconf -z /etc/named.conf:
  cmd.run:
    - cwd: /

