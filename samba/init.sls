
samba.dependancies:
  pkg.installed:
    - pkgs:
      - samba

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
  
