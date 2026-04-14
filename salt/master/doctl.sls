# 1. Install dependencies
doctl_dependencies:
  pkg.installed:
    - pkgs:
      - tar
      - gzip
      - python3-pip

install_salt_do_library:
  pip.installed:
    - name: python-digitalocean
    - reload_modules: True  # Vital: tells Salt to find the new DO modules immediately
    - require:
      - pkg: doctl_dependencies

# 2. Extract the binary
ensure_doctl_binary_exists:
  cmd.run:
    - name: /usr/local/sbin/update_doctl
    - unless: test -f /usr/local/bin/doctl

set_doctl_permissions:
  file.managed:
    - name: /usr/local/bin/doctl
    - mode: 755
    - replace: False

# 3. Create the configuration directory
doctl_config_dir:
  file.directory:
    - name: /root/.config/doctl
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

# 4. Authenticate doctl using Pillar data
doctl_auth_config:
  file.managed:
    - name: /root/.config/doctl/config.yaml
    - user: root
    - group: root
    - mode: 600
    - contents: |
        access-token: {{ pillar['do_token'] }}
    - require:
      - file: doctl_config_dir
