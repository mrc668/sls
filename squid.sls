{% set definedOS = salt['grains.filter_by']({
    'default': {'pkgname': 'squid', 'svcname': 'squid' },
  }, 
    default='default',
    grain='os'
  ) 
%}

squid:
  pkg:
    - installed
    - name: {{definedOS.pkgname}}
  service.running: 
    - name: {{definedOS.svcname}}
    - enable: true
    - watch:
      - file: /etc/squid/squid.conf

{% set definedHost = salt['grains.filter_by']({
    'default': {'src': 'squid.conf' },
  }, 
    default='default',
    grain='localhost'
  ) 
%}

/etc/squid/squid.conf:
  file.managed:
    - source: salt://managedFiles/squid/squid.conf
    - user: root
    - group: root
    - mode: 644

/etc/squid/cachemgr.conf:
  file.managed:
    - source: salt://managedFiles/squid/cachemgr.conf
    - user: root
    - group: root
    - mode: 644

/etc/squid/errorpage.css:
  file.managed:
    - source: salt://managedFiles/squid/errorpage.css
    - user: root
    - group: root
    - mode: 644

/etc/logrotate.d/squid:
  file.managed:
    - source: salt://managedFiles/squid/logrotate.conf
    - user: root
    - group: root
    - mode: 644


/usr/bin/chmod a+r /var/log/squid/access.log:
  cmd.run

/usr/bin/chmod a+r /var/log/squid/cache.log:
  cmd.run

