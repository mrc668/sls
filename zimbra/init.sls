zimbra.dependancies: 
  pkg.installed:
    - pkgs:
      - git
      - wget
      - nmon
      - tmux
      - unzip
      - net-tools
      - sysstat
      - openssh-clients
      - perl
      - libaio
      - nmap-ncat
      - bash-completion
      - vim-enhanced
      - curl
      - telnet
      - libstdc++
      - bind-utils 
      - patch
      # I'm not 100% sure these need to be included
      - perl-IO-stringy
      - perl-Unix-Syslog
      - perl-MIME-tools
      - perl-Net-LibIDN
      - perl-Net-Server
      - perl-ZMQ-Constants
      - gcc

zimbra.scripts:
  file.recurse:
    - name: /usr/local/sbin
    - source: salt://sls/zimbra/bin
    - exclude_pat: .*.swp
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 755

zimbra.repo:
  file.managed:
    - name: /etc/yum.repos.d/zimbra.repo
    - source: salt://sls/zimbra/repo
    - user: root
    - group: root
    - mode: 644

zimbra.profile:
  file.managed:
    - name: /etc/profile.d/zimbra.sh
    - source: salt://sls/zimbra/profile
    - user: root
    - group: root
    - mode: 644

zmamavisdctl.patch:
  file.managed:
    - name: /opt/zimbra/docs/zmamavisdctl.patch
    - source: salt://sls/zimbra/zmamavisdctl.patch
    - user: zimbra
    - group: zimbra
    - mode: 644

zmamavisdctl.patch.run:
  cmd.run:
    - name: /usr/local/sbin/zimbra-patch-zmamavisctl
    - cwd: /

/etc/sudoers.d/zabbixZimbra:
  file.managed:
    - source: salt://sls/zimbra/sudo
    - user: root
    - group: root
    - mode: 440

# A warning for external emails.

