saltMaster.dependancies:
  pkg.installed:
    - pkgs:
      - yamllint
      - git
      - patch
      - diffutils

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


