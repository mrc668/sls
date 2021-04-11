#/etc/hosts:
#  file.managed:
#    - source: salt://managedFiles/hosts
#    - user: root
#    - group: root
#    - mode: 644
#
#
logger:
  host.present:
    - ip: 10.0.10.12

salt:
  host.present:
    - ip: 10.0.10.6


