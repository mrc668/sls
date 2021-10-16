# required package
#nfs-utils
# cent 7: createrepo
# sdl 8: createrepo_c

include:
  - sls/nas2012

/etc/cron.daily/repomirror:
  file.managed:
    - source: salt://pillars/repomirror/cron
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/repomirror:
  file.managed:
    - source: salt://pillars/repomirror/repomirror
    - user: root
    - group: root
    - mode: 755

