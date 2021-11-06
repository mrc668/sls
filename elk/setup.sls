
elk.dependancies: 
  pkg.installed:
    - pkgs:
      - nmon
      - jq
      - java-1.8.0-openjdk

/etc/yum.repos.d/elk.repo:
  file.managed:
    - source: salt://sls/elk/setup/repo
    - user: root
    - group: root
    - mode: 644

/etc/profile.d/elk.sh:
  file.managed:
    - source: salt://sls/elk/setup/profile
    - user: root
    - group: root
    - mode: 644

