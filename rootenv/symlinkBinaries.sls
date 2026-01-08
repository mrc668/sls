{% set bin_dir = '/usr/local/bin' %}
{% set sbin_dir = '/usr/local/sbin' %}

# Ensure the destination directory exists
ensure_sbin_exists:
  file.directory:
    - name: {{ sbin_dir }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

# Loop through every file found in /usr/local/bin
{% for filename in salt['file.readdir'](bin_dir) %}
# Skip the special '.' and '..' directories
{% if filename not in ['.', '..'] %}

{{ sbin_dir }}/{{ filename }}:
  file.symlink:
    - target: {{ bin_dir }}/{{ filename }}
    - force: True  # Overwrite if a file already exists in sbin
    - require:
      - file: ensure_sbin_exists

{% endif %}
{% endfor %}
