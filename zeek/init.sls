# salt zeek state.apply sls/zeek
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
    - source: salt://sls/zeek/repo
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

uls_zeek:
  file.recurse:
    - source: salt://sls/zeek/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755

include:
  - sls/zeek/postpackage
  - sls/zeek/zkg
#  - sls/zeek/otx # No longer support otx in zeek. Moved to perimiter.

/usr/local/sbin/zeek-beats:
  cmd.run:
      - cwd: /
      - runas: root

