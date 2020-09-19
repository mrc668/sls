/etc/hosts:
  file.managed:
    - source: salt://managedFiles/hosts
    - user: root
    - group: root
    - mode: 644


