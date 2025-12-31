/etc/sysctl.d:
  file.recurse:
    - name: /etc/sysctl.d
    - source: salt://sls/sysctl/dotd
    - user: root
    - group: root
    - dir_mode: 755
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

# Get the pillar 'is_gateway', default to False if not found
{% if salt['pillar.get']('is_gateway', False) %}
  {% set fwd_value = 1 %}
{% else %}
  {% set fwd_value = 0 %}
{% endif %}

manage_ip_forwarding:
  sysctl.present:
    - name: net.ipv4.ip_forward
    - value: {{ fwd_value }}

