{% set epel_enabled = salt['pillar.get']('epel:repo:enabled', 1) %}
{% set epel_debug_enabled = salt['pillar.get']('epel:debug:enabled', 0) %}
{% set epel_source_enabled = salt['pillar.get']('epel:source:enabled', 0) %}

epel_main_repo:
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 9 - $basearch
    - metalink: https://mirrors.fedoraproject.org/metalink?repo=epel-9&arch=$basearch&infra=$infra&content=$contentdir
    - gpgcheck: 1
    - enabled: 1
    - countme: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

epel_debuginfo_repo:
  pkgrepo.managed:
    - name: epel-debuginfo
    - humanname: Extra Packages for Enterprise Linux 9 - $basearch - Debug
    - metalink: https://mirrors.fedoraproject.org/metalink?repo=epel-debug-9&arch=$basearch&infra=$infra&content=$contentdir
    - gpgcheck: 1
    - enabled: {{ epel_debug_enabled }}
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

epel_source_repo:
  pkgrepo.managed:
    - name: epel-source
    - humanname: Extra Packages for Enterprise Linux 9 - $basearch - Source
    - metalink: https://mirrors.fedoraproject.org/metalink?repo=epel-source-9&arch=$basearch&infra=$infra&content=$contentdir
    - gpgcheck: 1
    - enabled: {{ epel_source_enabled }}
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-9

# What the pillar will look like:
#epel:
#  debug:
#    enabled: 1  # Change to 1 to enable
#  source:
#    enabled: 0
