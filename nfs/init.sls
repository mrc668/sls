nfs.server:
  pkg:
    - installed
    - name: nfs-utils
  service.running:
    - enable: true
    - watch:
      - file: /etc/exports

/etc/exports:
  file.managed:
    - source: salt://personality/{{ grains['nodename'] }}/exports
    - user: root
    - group: root
    - mode: 644


