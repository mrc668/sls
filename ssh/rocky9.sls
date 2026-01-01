# /opt/sls/ssh/rocky9.sls

openssh_package:
  pkg.installed:
    - name: openssh-server

# Manage your custom overrides in the modular directory
sshd_config_files:
  file.recurse:
    - source: salt://ssh/r9_sshd_config_d
    - name: /etc/ssh/sshd_config.d
    - user: root
    - group: root
    - file_mode: 600
    - dir_mode: 700

# The main config that includes the .d directory
sshd_main_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://ssh/r9_sshd_config
    - user: root
    - group: root
    - mode: 600
    - check_cmd: /usr/sbin/sshd -t -f

sshd_service:
  service.running:
    - name: sshd
    - enable: True
    - watch:
      - file: sshd_main_config
      - file: sshd_config_files
