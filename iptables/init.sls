iptables-services:
  pkg:
    - installed
  service.running: 
    - name: iptables
    - enable: true
    - watch:
      - file: /etc/sysconfig/iptables

/etc/sysconfig/iptables:
  file.managed:
    - source: salt://personality/{{ grains['id']}}/iptables
    - user: root
    - group: root
    - mode: 600

# /opt/sls/firewall/mask.sls

# First, ensure the service is stopped
stop_firewalld:
  service.dead:
    - name: firewalld
    - enable: False

# Then, mask it so it cannot be started again
mask_firewalld:
  service.masked:
    - name: firewalld
    - require:
      - service: stop_firewalld
