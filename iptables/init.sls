/etc/sysconfig/iptables:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/iptables
    - user: root
    - group: root
    - mode: 600

iptables-services:
  pkg:
    - installed
  service.running: 
    - name: iptables
    - enable: true
    - watch:
      - file: /etc/sysconfig/iptables

# Ensure that /sbin/iptables exists
/usr/local/sbin/sbinIPTables:
  file.managed:
    - source: salt://sls/iptables/sbinIPTables
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /

/usr/local/sbin/networkManager:
  file.managed:
    - source: salt://sls/iptables/networkManager
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /

