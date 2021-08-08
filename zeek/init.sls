# salt zeek state.apply sls/zeek
{% set definedOS = salt['grains.filter_by']({
    'empty': {'pkgname': 'zeek-lts', 'svcname': 'zeek' },
  }, 
    default='empty',
    grain='os'
  ) 
%}

include:
  - sls/zeek/repo
  - sls/zeek/zeek
  - sls/zeek/postpackage
  - sls/zeek/zkg

/usr/local/sbin/zeek-beats:
  cmd.run:
      - cwd: /
      - runas: root

