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
    - dir_mode: 750
    - file_mode: 640

#/etc/openvpn/ccd:
#  file.directory:
#    - user: openvpn
#    - group: openvpn
#    - mode: 750
#

#/usr/bin/systemctl enable openvpn-server@server:
#  cmd.run:
#    - cwd: /

/etc/openvpn/server/Makefile:
  file.managed:
    - source: salt://sls/openvpn/Makefile
    - user: openvpn
    - group: openvpn
    - mode: 640

openvpnserver.make:
  cmd.run:
    - cwd: /
    - name: make -f /etc/openvpn/server/Makefile

/usr/bin/systemctl enable openvpn-client@eotn:
  cmd.run:
    - cwd: /

