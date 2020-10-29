/usr/local/sbin/saltrepo:
  file.managed:
    - source: salt://managedFiles/saltrepo
    - user: root
    - group: root
    - mode: 755
