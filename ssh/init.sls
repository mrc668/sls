{% set definedOS = salt['grains.filter_by']({
    'CentOS': {'pkgname': 'openssh-server', 'svcname': 'sshd' },
    'empty': {'pkgname': 'openssh-server', 'svcname': 'sshd' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

{% if grains['ssh_passwords'] is defined %}
{% set sshd = "sshd_config_passwords" %}
{% else %}
{% set sshd = "sshd_config" %}
{% endif %}

sshd:
  pkg:
    - installed
  service.running: 
    - name: {{definedOS.pkgname}}
    - enable: true
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://sls/ssh/{{sshd}}
    - user: root
    - group: root
    - mode: 640


