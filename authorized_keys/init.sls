{% set all_keys = salt['pillar.get']('ssh_keys', {}) %}
{% set my_users = salt['pillar.get']('minion_keys:' ~ grains['id'], {}) %}

{% for user, keys in my_users.items() %}
  {% set home = '/root' if user == 'root' else '/home/' ~ user %}

# Ensure the .d directory exists
{{ user }}_ssh_dot_d:
  file.directory:
    - name: {{ home }}/.ssh/authorized_keys.d
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

# Deploy only the keys specified for this user on this host
  {% for key_id in keys %}
{{ user }}_key_{{ key_id }}:
  file.managed:
    - name: {{ home }}/.ssh/authorized_keys.d/{{ key_id }}.pub
    - contents: {{ all_keys[key_id] }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
  {% endfor %}

# Deploy the Makefile to the .ssh directory
{{ user }}_ssh_makefile:
  file.managed:
    - name: {{ home }}/.ssh/Makefile
    - source: salt://authorized_keys/Makefile-authorized_keys
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644

# Rebuild authorized_keys if the .d content changes
# We use a wildcard watch to catch any added/removed/changed key
{{ user }}_rebuild_keys:
  cmd.run:
    - name: make
    - cwd: {{ home }}/.ssh
    - onchanges:
      - file: {{ home }}/.ssh/authorized_keys.d/*
{% endfor %}
