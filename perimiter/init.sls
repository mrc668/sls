/etc/cron.d/blocklists:
  file.absent

/usr/local/sbin/spamhaus:
  file.absent

/etc/cron.d/ids:
  file.managed:
    - source: salt://pillars/perimiter/cron
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

/usr/local/sbin/updateISCblocks:
  file.managed:
    - source: salt://pillars/perimiter/updateISCblocks
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/parseConnTrack:
  file.managed:
    - source: salt://pillars/perimiter/parseConnTrack
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/viewBlackLists:
  file.managed:
    - source: salt://pillars/perimiter/viewBlackLists
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/updateSpamhaus:
  file.managed:
    - source: salt://pillars/perimiter/updateSpamhaus
    - user: root
    - group: root
    - mode: 755

