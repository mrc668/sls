firewalld:
  pkg:
    - installed
  service.dead: 
    - running: false
    - enable: false
    - mask: true

iptables-services:
  pkg:
    - installed
  service.running: 
    - name: iptables
    - enable: true
    - watch:
      - file: /etc/sysconfig/iptables
      - file: /sbin/iptables

/etc/sysconfig/iptables:
  file.managed:
    - source: 
      - salt://personality/{{ grains['nodename'] }}/iptables
      - salt://managedFiles/iptables.open
    - user: root
    - group: root
    - mode: 600

/sbin/iptables:
  file.symlink:
    - target: /sbin/xtables-multi

/usr/sbin/iptables:
  file.symlink:
    - target: /usr/sbin/xtables-multi

