# /opt/sls/chrony/init.sls

include:
# Get the pillar 'is_timeserv', default to False if not found
{% if salt['pillar.get']('is_timeserv', False) %}
  - chrony/timeserv
{% else %}
  - chrony/client
{% endif %}

