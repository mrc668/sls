# 1. Install the iptables-services package to get the systemd unit files
install_iptables_services:
  pkg.installed:
    - name: iptables-services

# 2. Set default policies to DROP for IPv6
ipv6_deny_all_input:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: DROP
    - family: ipv6

ipv6_deny_all_forward:
  iptables.set_policy:
    - table: filter
    - chain: FORWARD
    - policy: DROP
    - family: ipv6

ipv6_deny_all_output:
  iptables.set_policy:
    - table: filter
    - chain: OUTPUT
    - policy: DROP
    - family: ipv6

# 3. Allow Loopback (Recommended) 
# Even on a "Deny All" system, internal apps often need the loopback interface
allow_ipv6_loopback:
  iptables.append:
    - table: filter
    - chain: INPUT
    - in-interface: lo
    - jump: ACCEPT
    - family: ipv6

# 4. Ensure the service is running and enabled on boot
ip6tables_service:
  service.running:
    - name: ip6tables
    - enable: True
    - require:
      - pkg: install_iptables_services
    - watch:
      - iptables: ipv6_deny_all_input
      - iptables: ipv6_deny_all_forward
      - iptables: ipv6_deny_all_output
