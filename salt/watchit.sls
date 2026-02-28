# Create a symbolic link for easier log monitoring
watchit_symlink:
  file.symlink:
    - name: /var/log/watchit
    - target: /var/log/salt-call.log
    - force: True
    - user: root
    - group: root

