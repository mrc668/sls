/etc/systemd/system/zeek.service:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://sls/zeek/zeek.service.jinja
  service.enabled: 
    - name: zeek

{% set definedPath = salt['grains.filter_by']({
    'zeek': {'node': 'personality/zeek/zeek-node.cfg', 'networks': 'personality/zeek/zeek-networks.cfg' },
    'empty': {'node': 'sls/zeek/node.cfg',  'networks': 'sls/zeek/zeek-networks.cfg' },
  }, 
  default='empty',
  grain='localhost'
  ) 
%}

#/etc/cron.d/zeek:
#  file.managed:
#    - source: salt://sls/zeek/cron
#    - user: root
#    - group: root
#    - mode: 644
#
/etc/profile.d/zeek.sh:
  file.managed:
    - source: salt://sls/zeek/profile.d
    - user: root
    - group: root
    - mode: 644

#- source: salt://{{ definedPath.node }}
/opt/zeek/etc/node.cfg:
  file.managed:
    - user: zeek
    - group: zeek
    - mode: 644
    - template: jinja
    - names:
      - /opt/zeek/etc/node.cfg:
        - source: salt://sls/zeek/node.cfg.jinja

/opt/zeek/etc/networks.cfg:
  file.managed:
    - source: salt://{{ definedPath.networks }}
    - user: zeek
    - group: zeek
    - mode: 644

/usr/bin/chown -R zeek:zeek /opt/zeek:
  cmd.run

#/usr/local/sbin/uli:
#  file.managed:
#    - source: salt://sls/zeek/uli
#    - user: root
#    - group: root
#    - mode: 755
#  cmd.run:
#      - cwd: /

