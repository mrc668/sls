#  https://repo.saltstack.com/py3/redhat/salt-py3-repo-3001.el7.noarch.rpm
{% set definedOS = salt['grains.filter_by']({
    'empty': {'pkgname': 'salt-minion', 'svcname': 'salt-minion' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

#{% if grains['os'] == 'Springdale Open Enterprise' %}
#include:
#  - sls/salt/sdlSalt
#{% endif %}

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

salt3003:
  file.absent:
    - name: /etc/cron.daily/salt3003.sh

upgrade:
  file.managed:
    - name: /etc/cron.daily/saltrepo.sh
    - source: salt://sls/salt/saltrepo.sh
    - user: root
    - group: root
    - mode: 755

/usr/local/sbin/saltcall:
  file.managed:
    - source: salt://sls/salt/saltcall
    - user: root
    - group: root
    - mode: 755

