openvpn.dependancies: 
  pkg.installed:
    - pkgs:
      - samba-client
      - openvpn

vpn.scripts:
  file.recurse:
    - source: salt://sls/openvpn/bin
    - name: /usr/local/sbin
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - file_mode: 755

/etc/openvpn:
  file.recurse:
    - source: salt://personality/{{ grains['nodename']}}/openvpn
    - name: /etc/openvpn
    - exclude_pat: .*.swp
    - user: openvpn
    - group: openvpn
    - dir_mode: 700
    - file_mode: 600

#/etc/openvpn/ccd:
#  file.directory:
#    - user: openvpn
#    - group: openvpn
#    - mode: 750
#
/usr/bin/systemctl enable openvpn-server@server:
  cmd.run:
    - cwd: /

/usr/bin/systemctl enable openvpn-client@eotn:
  cmd.run:
    - cwd: /

