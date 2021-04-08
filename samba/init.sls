
samba.dependancies:
  pkg.installed:
    - pkgs:
      - samba
      - fuse-encfs

samba.service:
  service.running: 
    - name: smb
    - enable: true
    - watch:
      - file: /etc/samba/smb.conf

# Run 'testparm' to verify the config is correct after
# you modified it.
/etc/samba/smb.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://personality/{{grains["nodename"]}}/smb.conf
  

/usr/local/sbin/provide:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - source: salt://sls/samba/provide
  
/root/.key:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - source: salt://personality/{{grains["nodename"]}}/encfs.key
  
/root/.encfs.xml:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - source: salt://personality/{{grains["nodename"]}}/encfs6.xml
  
