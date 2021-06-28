#  https://repo.saltstack.com/py3/redhat/salt-py3-repo-3001.el7.noarch.rpm
{% set definedOS = salt['grains.filter_by']({
    'empty': {'pkgname': 'salt-minion', 'svcname': 'salt-minion' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

salt-minion:
  pkg:
    - installed
    - name: {{definedOS.pkgname}}
  service.running: 
    - name: {{definedOS.svcname}}
    - enable: true
    - watch:
      - file: /etc/salt/minion

/etc/salt/minion:
  file.managed:
    - source: salt://sls/salt/minion
    - user: root
    - group: root
    - mode: 644

/etc/cron.d/salt:
  file.managed:
    - source: salt://sls/salt/cron
    - user: root
    - group: root
    - mode: 644

/etc/logrotate.d/salt:
  file.managed:
    - source: salt://sls/salt/logrotate
    - user: root
    - group: root
    - mode: 644



