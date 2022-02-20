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

