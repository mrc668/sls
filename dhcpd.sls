dhcpd-service:
  pkg:
    - installed
  service.running: 
    - name: dhcpd
    - enable: true
    - watch:
      - file: /etc/dhcp/dhcpd.conf

