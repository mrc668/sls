nfs.server:
  pkg:
    - installed
    - name: nfs-utils
  service.running:
    - enable: true
    - name: nfs-server
    - watch:
      - file: /etc/exports

rpcbind:
  pkg:
    - installed
  service.running:
    - enable: true
    - name: rpcbind

/etc/exports:
  file.managed:
    - source: salt://personality/{{ grains['nodename'] }}/exports
    - user: root
    - group: root
    - mode: 644


