openvpn.dependancies: 
  pkg.installed:
    - pkgs:
      - openvpn

/etc/openvpn:
  file.recurse:
    - source: salt://personality/{{ grains['nodename']}}/openvpn
    - name: /etc/openvpn
    - exclude_pat: .*.swp
    - user: openvpn
    - group: openvpn
    - dir_mode: 750
    - file_mode: 640

/usr/bin/systemctl enable openvpn-client@eotn:
  cmd.run:
    - cwd: /

