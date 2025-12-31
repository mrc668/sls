# Disable IPv6 for all interfaces
disable_ipv6_all:
  sysctl.present:
      - name: net.ipv6.conf.all.disable_ipv6
          - value: 1
