/opt/zeek/share/zeek/site/packages/dovehawk/config.zeek:
  file.managed:
    - source: salt://sls/zeek/config.zeek
    - user: zeek
    - group: zeek
    - mode: 644

