/etc/sysctl.d:
  file.recurse:
    - name: /etc/sysctl.d
    - source: salt://sls/sysctl/dotd
    - user: root
    - group: root
    - dir_more: 755
    - file_mode: 644

{% set definedVer = salt['grains.filter_by']({
    'devil': {'ver': '1' },
    'unibasegw': {'ver': '1' },
    'kmpgw2020': {'ver': '1' },
    'empty': {'ver': '0' },
  }, 
    default='empty',
    grain='nodename'
  ) 
%}

{% if grains['ipfwd'] is defined %}
{% set ipfwd = "1" %}
{% else %}
{% set ipfwd = "0" %}
{% endif %}

/etc/sysctl.d/forward.conf:
  file.managed:
    - source: salt://sls/sysctl/forward.conf{{ipfwd}}
    - user: root
    - group: root
    - mode: 644

