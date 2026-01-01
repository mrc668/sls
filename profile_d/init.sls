
profile_d.files:
  file.recurse:
    - source: salt://profile_d/etc
    - name: /etc/profile.d
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

/etc/sudoers:
  file.managed:
    - source: salt://profile_d/sudoers
    - user: root
    - group: root
    - mode: 640
