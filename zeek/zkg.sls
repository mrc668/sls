/usr/bin/pip3 install --user zeek zkg:
  cmd.run:
    - cwd: /

/home/zeek/installZKG:
  file.managed:
    - source: salt://sls/zeek/installZKG
    - user: zeek
    - group: zeek
    - mode: 755
  cmd.run:
      - cwd: /home/zeek
      - runas: zeek

/opt/zeek/share/zeek/site/local.zeek:
  file.managed:
    - source: salt://sls/zeek/local.zeek
    - user: zeek
    - group: zeek
    - mode: 644

