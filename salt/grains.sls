
/etc/salt/minion.d/grains.conf:
  file.managed:
    - source: salt://personality/{{grains['nodename']}}/grains.conf
    - user: root
    - group: root
    - mode: 644

include:
  - salt/restart-minion

