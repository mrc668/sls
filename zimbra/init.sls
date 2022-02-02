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

zimbra.scripts:
  file.recurse:
    - name: /usr/local/sbin
    - source: salt://sls/zimbra/bin
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
