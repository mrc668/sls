{% set definedOS = salt['grains.filter_by']({
    'empty': {'pkgname': 'squid', 'svcname': 'squidd' },
  }, 
    default='empty',
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
    'empty': {'src': 'squid.conf' },
  }, 
    default='empty',
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

