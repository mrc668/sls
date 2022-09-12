include:
  - users/docker
  - sls/docker/fs
  - sls/docker/{{ grains['os_family']}}

#uls_docker:
#  file.recurse:
#    - source: salt://sls/docker/bin
#    - name: /usr/local/sbin
#    - user: root
#    - group: root
#    - file_mode: 755
#
etc_docker:
  file.recurse:
    - source: salt://sls/docker/etc
    - name: /etc
    - user: root
    - group: root
    - file_mode: 644

