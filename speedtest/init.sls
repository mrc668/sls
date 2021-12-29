
{% set byOS = salt['grains.filter_by']
  (
    {
      'empty': {'python': 'python' },
      'CentOS': {'python': 'python3' },
      'Springdale Open Enterprise': {'python': 'python36' },
    },
    default='empty',
    grain='os'
  )
%}

speedtest.dependancies: 
  pkg.installed:
    - pkgs:
      - {{ byOS.python }}
      - zabbix-sender
      - jq

/usr/local/sbin/speedtest.sh:
  file.managed: 
    - source: salt://sls/speedtest/speedtest.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/speedtest-cli:
  file.absent

/etc/cron.d/speedtest:
  file.managed:
    - source: salt://sls/speedtest/cron
    - user: root
    - group: root
    - mode: 644


