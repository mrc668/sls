{% set definedOS = salt['grains.filter_by']({
    'CentOS': {'pkgname': 'ntp', 'svcname': 'ntpd', 'sls': 'centos' },
    'Springdale Open Enterprise': {'pkgname': 'chrony', 'svcname': 'chronyd', 'sls': 'sdl' },
    'empty': {'pkgname': 'ntp', 'svcname': 'ntpd' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

include:
  - sls/ntp/{{ definedOS.sls }}

