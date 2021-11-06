
{% set definedRole = salt['grains.filter_by']({
    'default': {'src': 'repo' },
  }, 
    default='default',
    grain='localhost'
  ) 
%}

elk.dependancies: 
  pkg.installed:
    - pkgs:
      - nmon
      - jq

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

