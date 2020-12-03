{% set definedOS = salt['grains.filter_by']({
    'CentOS': {'pkgname': 'openssh-server', 'svcname': 'sshd' },
    'empty': {'pkgname': 'openssh-server', 'svcname': 'sshd' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

ssh:
  pkg:
    - installed
    - name: {{definedOS.pkgname}}
  service.running: 
    - name: {{definedOS.svcname}}
    - enable: true
    - watch:
      - file: /etc/ssh/sshd_config

{% set definedRole = salt['grains.filter_by']({
    'unibasegw': {'src': 'sshd_config_passwords' },
    'mrcdesktop': {'src': 'sshd_config_passwords' },
    'empty': {'src': 'sshd_config' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://managedFiles/{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644

/root/.ssh:
  file.directory:
    - user: root
    - group: root
    - mode: 700

{% set ak = salt['grains.filter_by']({
    'backup': {'src': "personality/backup/ssh//authorized_keys"  },
    'default': {'src': 'managedFiles/authorized_keys'  },
  }, 
    default='default',
    grain='nodename'
  ) 
%}
/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://{{ak.src}}
    - user: root
    - group: root
    - mode: 600


