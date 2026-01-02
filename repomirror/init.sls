# required package
#nfs-utils
# cent 7: createrepo - not worring about cent 7 any more.
# sdl 8: createrepo_c

{% set os_major = grains['osmajorrelease'] | int %}

{% if os_major == 8 %}
repomirror.dependencies: 
  pkg.installed:
    - pkgs:
      - createrepo_c
{% elif os_major == 9 %}
repomirror.dependencies: 
  pkg.installed:
    - pkgs:
      - createrepo_c
      - yum-utils
{% endif %}

include:
  - tnas2025

repomirror.cron:
  file.managed:
    - source: salt://repomirror/cron
    - name: /etc/cron.daily/repomirror
    - user: root
    - group: root
    - mode: 755
    - follow_symlinks: False

repomirror.bin:
  file.managed:
    - source: salt://repomirror/repomirror
    - name: /usr/local/sbin/repomirror
    - user: root
    - group: root
    - mode: 755

repomirror.etc:
  file.managed:
    - source: salt://personality/{{ grains['id']}}/repomirror
    - name: /etc/sysconfig/repomirror
    - user: root
    - group: root
    - mode: 644


