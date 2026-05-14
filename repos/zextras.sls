{% set zextras_enabled = salt['pillar.get']('zextras:repo:enabled', 0) %}

zextras_repo_managed:
  pkgrepo.managed:
    - name: zextras
    - humanname: zextras
    - baseurl: https://repo.zextras.io/release/rhel9
    - enabled: {{ zextras_enabled }}
    - repo_gpgcheck: 1
    - gpgcheck: 0
    - gpgkey: https://repo.zextras.io/repomd.xml.key
