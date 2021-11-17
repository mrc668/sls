
ipset.dependancies: 
  pkg.installed:
    - pkgs:
      - ipset

/usr/local/sbin/ipset.convert:
  file.managed:
    - source: salt://sls/ipset/ipset.convert
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/ipset.load:
  file.managed:
    - source: salt://sls/ipset/ipset.load
    - user: root
    - group: root
    - mode: 755

/etc/systemd/system/ipset.service:
  file.managed:
    - source: salt://sls/ipset/ipset.service
    - user: root
    - group: root
    - mode: 644


/usr/bin/systemctl enable ipset:
  cmd.run

/etc/sysconfig/ipsets:
  file.recurse:
    - source: salt://sls/ipset/ipsets
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

