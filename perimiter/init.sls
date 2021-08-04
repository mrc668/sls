/etc/cron.d/blocklists:
  file.absent

/usr/local/sbin/spamhaus:
  file.absent

/etc/cron.d/ids:
  file.managed:
    - source: salt://sls/perimiter/cron
    - user: root
    - group: root
    - mode: 644

perimeter.dependancies: 
  pkg.installed:
    - pkgs:
      - wget
      - perl

/usr/local/sbin/updateBlackList:
  file.absent

/usr/local/sbin/clearBlackList:
  file.absent

uls_perimeter:
  file.recurse:
    - source: salt://sls/perimiter/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755

