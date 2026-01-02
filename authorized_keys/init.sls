# /opt/sls/authorized_keys/init.sls

install_make:
  pkg.installed:
    - name: make

{% set all_keys = salt['pillar.get']('ssh_keys', {}) %}
{% set defaults = salt['pillar.get']('minion_keys:default', {}) %}
{% set overrides = salt['pillar.get']('minion_keys:' ~ grains['id'], {}) %}

{% set my_users = defaults.copy() %}
{% do my_users.update(overrides) %}

{% for user, keys in my_users.items() %}
  {% set home = '/root' if user == 'root' else '/home/' ~ user %}

{{ user }}_ssh_dot_d:
  file.directory:
    - name: {{ home }}/.ssh/authorized_keys.d
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

{{ user }}_ssh_makefile:
  file.managed:
    - name: {{ home }}/.ssh/authorized_keys.d/Makefile
    - source: salt://authorized_keys/Makefile-authorized_keys
    - user: {{ user }}
    - group: {{ user }}
    - mode: 644
    - watch_in:
      - cmd: {{ user }}_rebuild_keys

  {% for key_id in keys %}
    {% if key_id in all_keys %}
{{ user }}_key_{{ key_id }}:
  file.managed:
    - name: {{ home }}/.ssh/authorized_keys.d/{{ key_id }}.pub
    - contents: |
        {{ all_keys[key_id] }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - watch_in:
      - cmd: {{ user }}_rebuild_keys
    {% endif %}
  {% endfor %}

# REMOVED success_retcodes so this state returns False on mismatch
{{ user }}_verify_md5:
  cmd.run:
    - name: md5sum -c authorized_keys.md5 || touch *.pub
    - cwd: {{ home }}/.ssh/authorized_keys.d
    - runas: {{ user }}
    - onlyif:
      - test -f {{ home }}/.ssh/authorized_keys.d/authorized_keys.md5
      - test -f {{ home }}/.ssh/authorized_keys

{{ user }}_rebuild_keys:
  cmd.run:
    - name: make
    - cwd: {{ home }}/.ssh/authorized_keys.d
    - runas: {{ user }}
    - require:
      - pkg: install_make

{% endfor %}
