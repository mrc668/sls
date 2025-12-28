reload_systemd_daemon:
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: fw-salt-master.service

saltMaster.dependancies:
  pkg.installed:
    - pkgs:
      - yamllint
      - git
      - patch
      - diffutils
      - cronie

/etc/cron.d/saltMastercron:
  file.managed:
    - source: salt://sls/salt/master/saltMastercron
    - user: root
    - group: root
    - mode: 644

saltMasterStart:
  file.managed:
    - name: /usr/local/sbin/saltMasterStart
    - source: salt://sls/salt/master/saltMasterStart
    - user: root
    - group: root
    - mode: 755

fw-salt-master.service:
  file.managed:
    - name: /etc/systemd/system/fw-salt-master.service
    - source: salt://sls/salt/master/fw-salt-master.service
    - user: root
    - group: root
    - mode: 640
  service.enabled:
    - name: fw-salt-master
    - require:
      - module: reload_systemd_daemon
    - watch:
      - file: fw-salt-master.service

fw-add-salt-master:
  file.managed:
    - name: /usr/local/sbin/fw-add-salt-master
    - source: salt://sls/salt/master/fw-add-salt-master
    - user: root
    - group: root
    - mode: 750


