
{% set byOS = salt['grains.filter_by']
  (
    {
      'empty': {'repo': 'repo' },
      'CentOS': {'repo': 'repo-104-c7' },
      'Springdale Open Enterprise': {'repo': 'repo-104-s8' },
    },
    default='empty',
    grain='os'
  )
%}

/etc/yum.repos.d/mariadb.repo:
  file.managed:
    - source: salt://pillars/maria/{{byOS.repo}}
    - user: root
    - group: root
    - mode: 644

maria.pkgs: 
  pkg.installed:
    - pkgs:
      - MariaDB-client
      - MariaDB-server


/usr/local/sbin/backupMySQL:
  file.managed:
    - source: salt://pillars/maria/backupMySQL
    - user: root
    - group: root
    - mode: 755

/etc/logrotate.d/mariadb.conf:
  file.managed:
    - source: salt://pillars/maria/logrotate.conf
    - user: root
    - group: root
    - mode: 644

/etc/cron.d/maria:
  file.managed:
    - source: salt://pillars/maria/cron
    - user: root
    - group: root
    - mode: 644


