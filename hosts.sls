#/etc/hosts:

salt:
  host.present:
    - ip: 10.0.10.6

monitor:
  host.present:
    - ip: 10.0.10.3

