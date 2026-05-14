insert_nginx_out_rule:
  nftables.insert:
    - table: filter
    - family: inet
    - chain: OUTPUT
    - position: 4
    - rule: 'skuid nginx counter jump nginx_out'
    - save: True

nginx_oif_eth0:
  nftables.insert:
    - table: filter
    - family: inet
    - chain: nginx_out
    - position: 4
    - rule: 'oif "eth0" counter jump nginxXeth0'
    - save: True

nginx_oif_eth0:
  nftables.insert:
    - table: filter
    - family: inet
    - chain: nginxXeth0
    - position: 4
    - rule: 'tcp sport {80, 443} counter
    - save: True

