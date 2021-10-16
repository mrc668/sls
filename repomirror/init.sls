# required package
#nfs-utils
# cent 7: createrepo - not worring about cent 7 any more.
# sdl 8: createrepo_c

{% if grains['os'] == 'Springdale Open Enterprise' %}
repomirror.dependancies: 
  pkg.installed:
    - pkgs:
      - createrepo_c
{% endif %}

include:
  - sls/nas2012

/etc/cron.daily/repomirror:
  file.managed:
    - source: salt://sls/repomirror/cron
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/repomirror:
  file.managed:
    - source: salt://sls/repomirror/repomirror
    - user: root
    - group: root
    - mode: 755

