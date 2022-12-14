ntp:
  pkg:
    - installed
  service.running: 
    - name: ntpd
    - enable: true
    - watch:
      - file: /etc/ntp.conf
  user.present:
    - home: /etc/ntp
    - shell: /sbin/nologin

ntpdate:
  pkg:
    - installed
  service.disabled: 
    - name: ntpdate
    - enable: false

chronyd:
  service.disabled: 
    - name: chronyd
    - enable: false
    - running: false

{% set definedRole = salt['grains.filter_by']({
    'devil': {'src': 'personality/devil/ntp.conf' },
    'unibasegw': {'src': 'personality/unibasegw/ntp.conf' },
    'kmpgw2020': {'src': 'personality/kmpgw2020/ntp.conf' },
    'gpagw2106': {'src': 'personality/gpagw2106/ntp.conf' },
    'empty': {'src': 'sls/ntp/ntp.conf' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

/etc/ntp.conf:
  file.managed:
    - source: salt://{{definedRole.src}}
    - user: root
    - group: root
    - mode: 644

/usr/lib/systemd/system/ntpd.service:
  file.managed:
    - source: salt://sls/ntp/ntpd.service
    - user: root
    - group: root
    - mode: 644

/etc/ntp/step-tickers:
  file.managed:
    - source: salt://personality/{{ grains['nodename']}}/step-tickers
    - user: root
    - group: root
    - mode: 644

/usr/local/sbin/ntpScripts.sh:
  file.managed:
    - source: salt://sls/ntp/ntpScripts.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /

