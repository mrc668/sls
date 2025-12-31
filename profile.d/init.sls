
profile.d.files:
  file.recurse:
    - source: salt://sls/profile.d/etc
    - name: /etc/profile.d
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

