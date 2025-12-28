openvpn.dependancies: 
  pkg.installed:
    - pkgs:
      - openvpn
      # MFA only works for users, not service accounts.

vpn.scripts:
  file.recurse:
    - source: salt://sls/openvpn/bin
    - name: /usr/local/sbin
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - file_mode: 755

