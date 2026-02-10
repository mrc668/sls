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
install_doctl:
  archive.extracted:
    - name: /usr/local/bin/
    - source: https://github.com/digitalocean/doctl/releases/download/v1.148.0/doctl-1.148.0-linux-amd64.tar.gz
    - source_hash: sha256=c691a57d82440e1dc9034ed845db7e56c810b17320e56ad0ec96999536bf9046
    - enforce_toplevel: False
    - if_missing: /usr/local/bin/doctl

set_doctl_permissions:
  file.managed:
    - name: /usr/local/bin/doctl
    - mode: 755
    - replace: False
    - require:
      - archive: install_doctl

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
