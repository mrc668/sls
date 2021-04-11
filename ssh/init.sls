{% set definedOS = salt['grains.filter_by']({
    'CentOS': {'pkgname': 'openssh-server', 'svcname': 'sshd' },
    'empty': {'pkgname': 'openssh-server', 'svcname': 'sshd' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

ssh.dependancies:
  pkg.installed:
    - pkgs:
      - {{definedOS.pkgname}}

