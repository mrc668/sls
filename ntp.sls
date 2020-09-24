{% set definedOS = salt['grains.filter_by']({
    'CentOS': {'pkgname': 'ntp', 'svcname': 'ntpd' },
    'empty': {'pkgname': 'ntp', 'svcname': 'ntpd' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

ntp:
  pkg:
    - installed
  service.running: 
    - name: {{definedOS.svcname}}
    - enable: true
    - watch:
      - file: /etc/ntp.conf
  user.present:
    - home: /etc/ntp
    - shell: /sbin/nologin

{% set definedRole = salt['grains.filter_by']({
    'devil': {'src': 'ntp.conf_localtimeserver' },
    'unibasegw': {'src': 'ntp.conf_localtimeserver' },
    'empty': {'src': 'ntp.conf' },
  }, 
    default='empty',
    grain='localhost'
  ) 
%}

/etc/ntp.conf:
  file.managed:
    - source: salt://managedFiles/{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644


