
include:
{% if grains['os_family'] == 'RedHat' %}
  - sls/docker/rhel8
{% endif %}

