
/etc/sysctl.d/arp.conf:
  file.managed:
    - source: salt://managedFiles/sysctl/arp.conf
    - user: root
    - group: root
    - mode: 644

{% set definedVer = salt['grains.filter_by']({
    'devil': {'ver': '1' },
    'unibasegw': {'ver': '1' },
    'kmpgw2020': {'ver': '1' },
    'empty': {'ver': '0' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

/etc/sysctl.d/forward.conf:
  file.managed:
    - source: salt://managedFiles/sysctl/forward.conf{{definedVer.ver}}
    - user: root
    - group: root
    - mode: 644

/etc/sysctl.d/ipv6.conf:
  file.managed:
    - source: salt://managedFiles/sysctl/ipv6.conf
    - user: root
    - group: root
    - mode: 644

/etc/sysctl.d/keepalive.conf:
  file.managed:
    - source: salt://managedFiles/sysctl/keepalive.conf
    - user: root
    - group: root
    - mode: 644

/etc/sysctl.d/kernel.conf:
  file.managed:
    - source: salt://managedFiles/sysctl/kernel.conf
    - user: root
    - group: root
    - mode: 644

/etc/sysctl.d/rp_filter.conf:
  file.managed:
    - source: salt://managedFiles/sysctl/rp_filter.conf
    - user: root
    - group: root
    - mode: 644

