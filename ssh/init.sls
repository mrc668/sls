# /opt/sls/ssh/init.sls

include:
  {# Use | string to ensure the comparison works regardless of data type #}
  {% if salt['grains.get']('osmajorrelease') | string == '9' %}
  - ssh/rocky9
  {% else %}
  - ssh/legacy
  {% endif %}
