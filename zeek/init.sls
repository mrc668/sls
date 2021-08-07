# salt zeek state.apply pillars/zeek
{% set definedOS = salt['grains.filter_by']({
    'empty': {'pkgname': 'zeek-lts', 'svcname': 'zeek' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

zeek.dependancies: 
  pkg.installed:
    - pkgs:
      - cmake3
      - binpac
      - make
      - gcc
      - gcc-c++
      - flex
      - bison
      - gdb
      - swig
      - libpcap-devel
      - openssl-devel
      - zlib-devel
      - kernel-devel
      - kernel-headers
      - python3
      - python3-devel
      - python3-pip
      - git
      - tar
      - wget
      - unzip
      - bind-utils
      - whois

/etc/yum.repos.d/zeek.repo:
  file.managed:
    - source: salt://pillars/zeek/repo
    - user: root
    - group: root
    - mode: 644
  
zeek:
  pkg:
    - name: {{definedOS.pkgname}}
    - installed
  user.present:
    - name: zeek
    - home: /home/zeek
    - shell: /bin/bash
    - group: zeek

include:
  - pillars/zeek/postpackage
  - pillars/zeek/zkg
  - pillars/zeek/otx

