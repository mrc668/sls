
/etc/sysconfig/ns.md5:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/ns.md5
    - user: root
    - group: root
    - mode: 600

/etc/sysconfig/network-scripts:
  file.recurse:
    - name: /etc/sysconfig/network-scripts
    - source: salt://personality/{{ grains['nodename']}}/network-scripts
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

/usr/bin/md5sum -c ns.md5:
  cmd.run:
    - cwd: /etc/sysconfig 

