# 1. Deploy the script itself
deploy_salt_master_scripts:
  file.recurse:
    - name: /usr/local/sbin
    - source: salt://salt/master/bin
    - user: root
    - group: root
    - file_mode: '0755'  # Executable
    - exclude_pat: .*.swp

