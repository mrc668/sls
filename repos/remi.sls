{% set remi_enabled = salt['pillar.get']('remi:repo:enabled', 0) %}

# Only install the release RPM if the pillar is enabled
remi_release_rpm:
  pkg.installed:
    - name: https://rpms.remirepo.net/enterprise/remi-release-9.rpm
    - onlyif: {{ remi_enabled == 1 }}

# Manage the specific PHP repo definition
remi_php82_repo:
  pkgrepo.managed:
    - name: remi-php82
    - humanname: Remi's PHP 8.2 RPM repository for Enterprise Linux 9
    - mirrorlist: http://cdn.remirepo.net/enterprise/9/php82/mirror
    - enabled: {{ remi_enabled }}
    - gpgcheck: 1
    - gpgkey: https://rpms.remirepo.net/RPM-GPG-KEY-remi.el9
    - require:
      - pkg: remi_release_rpm
