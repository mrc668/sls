
/usr/local/sbin/selfCheck.sh:
  file.managed:
    - source: salt://pillars/selfCheck/selfCheck.sh.{{grains['nodename']}}
    - user: root
    - group: root
    - mode: 755

/etc/systemd/system/selfCheck.service:
  file.managed:
    - source: salt://pillars/selfCheck/selfCheck.service
    - user: root
    - group: root
    - mode: 644


/usr/bin/systemctl enable selfCheck:
  cmd.run

/usr/local/mp3:
  file.recurse:
    - source: salt://pillars/selfCheck/mp3
    - user: root
    - group: root
    - dir_more: 755
    - file_mode: 644

selfCheck.dependancies: 
  pkg.installed:
    - pkgs:
      - nagios-plugins-disk
      - nagios-plugins-fping
      - nagios-plugins-dns
      - nagios-plugins-nrpe
      - nagios-plugins-smtp
      - nagios-plugins-tcp
      - nagios-plugins-mysql
      - mpg123
      - alsa-tools
      - alsa-utils

# Maybe run this one by hand
#/sbin/alsactl init:
#  cmd.run
 
