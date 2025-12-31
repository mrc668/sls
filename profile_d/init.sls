
profile_d.files:
  file.recurse:
    - source: salt://sls/profile_d/etc
    - name: /etc/profile.d
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

