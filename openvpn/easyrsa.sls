easyrsa.dependancies: 
  pkg.installed:
    - pkgs:
      - easy-rsa
      - tar
      - zip

easyrsa.dirs:
  file.directory:
    - name: /opt/vpnkeys2025/conf
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

make_makeZip:
  file.manage:
    - source: salt://sls/openvpn/makeZip
    - name: /opt/vpnkeys2025/conf/makeZip
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: easyrsa.dirs

