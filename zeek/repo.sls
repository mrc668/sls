zeek.dependancies: 
  pkg.installed:
    - pkgs:
      - cmake
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
      - python36
      - python3-devel
      - python3-pip
      - platform-python-devel
      - git
      - tar
      - jq
      - wget
      - unzip
      - bind-utils
      - whois
      - rsync
      - numactl
      - network-scripts
      - epel-release
      - sssd-client

/etc/yum.repos.d/zeek.repo:
  file.managed:
    - source: salt://sls/zeek/repo
    - user: root
    - group: root
    - mode: 644
  
uls_zeek:
  file.recurse:
    - source: salt://sls/zeek/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755

