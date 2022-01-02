include:
  - sls/elk/setup
  - sls/beats/filebeat

beat.scripts:
  file.recurse:
    - source: salt://sls/elk/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755
    - dir_mode: 755

