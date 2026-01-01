# Ensure the yum/dnf utilities are installed
install_yum_utils:
  pkg.installed:
    - pkgs:
      - yum-utils
      - dnf-plugins-core

# Optional: Ensure the legacy yum symlink exists (usually default on Rocky 9)
yum_symlink:
  file.symlink:
    - name: /usr/bin/yum
    - target: /usr/bin/dnf
    - force: False

/etc/cron.daily/yum.daily:
  file.managed:
    - source: salt://yum/yum.daily
    - user: root
    - group: root
    - mode: 755

/etc/logrotate.d/yum-daily.conf:
  file.managed:
    - source: salt://yum/logrotate-yum.daily
    - user: root
    - group: root
    - mode: 644
