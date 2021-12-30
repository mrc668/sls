
install-ab:
  pkg:
    - installed
    - name: httpd-tools

techsmashwru.ru:
  host.absent:
    - ip: 103.153.183.146
    - names: 
      - techsmashwru.ru

abbyfire.ca:
  host.present:
    - ip: 13.74.160.19
    - names:
      - ups-onlinetracking.abbyfire.ca

mehdrek.tk:
  host.present:
    - ip: 104.21.65.213
    - names:
      - mehdrek.tk

uls_attack:
  file.recurse:
    - source: salt://sls/attack/bin
    - name: /usr/local/sbin
    - user: root
    - group: root
    - file_mode: 755


