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
    'devil': {'src': 'personality/devil/ntp.conf' },
    'unibasegw': {'src': 'personality/unibasegw/ntp.conf' },
    'empty': {'src': 'managedFiles/ntp.conf' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

/etc/ntp.conf:
  file.managed:
    - source: salt://{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644



/usr/bin/systemctl enable {{definedOS.svcname}}:
  cmd.run

