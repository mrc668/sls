
/opt/zeek/share/zeek/site/otx:
  file.directory:
    - user: zeek
    - group: zeek
    - mode: 755

/opt/zeek/share/zeek/site/otx/__load__.zeek:
  file.managed:
    - source: salt://pillars/zeek/otx/load.zeek
    - user: zeek
    - group: zeek
    - mode: 644

/opt/zeek/share/zeek/site/otx/zeek-otx.conf:
  file.managed:
    - user: zeek
    - group: zeek
    - mode: 644
    - template: jinja
    - source: salt://pillars/zeek/otx/zeek-otx.conf.jinja

/opt/zeek/share/zeek/site/otx/zeek-otx.py:
  file.managed:
    - source: salt://pillars/zeek/otx/zeek-otx.py
    - user: zeek
    - group: zeek
    - mode: 755
  cmd.run:
    - cwd: /opt/zeek/share/zeek/site/otx
    - runas: zeek


