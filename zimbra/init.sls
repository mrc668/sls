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
      - zabbix-sender
      # I'm not 100% sure these need to be included
      - perl-IO-stringy
      - perl-Unix-Syslog
      - perl-MIME-tools
      - perl-Net-LibIDN
      - perl-Net-Server
      - perl-ZMQ-Constants
      - gcc
      - rsync

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

localconfig.patch:
  file.managed:
    - name: /opt/zimbra/conf/localconfig.xml.patch
    - source: salt://sls/zimbra/localconfig.patch
    - user: zimbra
    - group: zimbra
    - mode: 640

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

zimbra.zabix.sudo:
  file.managed:
    - name: /etc/sudoers.d/zimbraZabix
    - source: salt://sls/zimbra/sudo
    - user: root
    - group: root
    - mode: 440

postfix_header_checks:
  file.managed:
    - name: /opt/zimbra/conf/custom_header_check
    - source: salt://sls/zimbra/postfix_header_checks
    - user: zimbra
    - group: zimbra
    - mode: 644

postfix_header_checks.run:
  cmd.run:
    - name: /usr/local/sbin/zimbra-LogSubject
    - runas: zimbra
    - onchanges:
      - file: postfix_header_checks

zimbra.cron:
  file.managed:
    - name: /etc/cron.d/zimbra.backup
    - source: salt://sls/zimbra/cron
    - user: root
    - group: root
    - mode: 440

