/etc/dhcp/dhcpd.conf:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/dhcpd.conf
    - user: root
    - group: root
    - mode: 644

dhcpd-service:
  pkg:
    - installed
    - name: dhcp
  service.running: 
    - name: dhcpd
    - enable: true
    - watch:
      - file: /etc/dhcp/dhcpd.conf

