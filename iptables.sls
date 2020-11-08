iptables-services:
  pkg:
    - installed
  service.running: 
    - name: iptables
    - enable: true
    - watch:
      - file: /etc/sysconfig/iptables

/usr/local/sbin/sbinIPTables:
  file.managed:
    - source: salt://managedFiles/sbinIPTables
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /
