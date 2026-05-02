# Install the Nginx Package
install_nginx:
  pkg.installed:
    - name: nginx

# Ensure the snippets directory exists for our global policies
nginx_snippets_dir:
  file.directory:
    - name: /etc/nginx/snippets
    - makedirs: True
    - require:
      - pkg: install_nginx

# Ensure the directory exists and sync all files within it
deploy_nginx_snippets:
  file.recurse:
    - name: /etc/nginx/snippets
    - source: salt://nginx/snippets
    - user: root
    - group: root
    - file_mode: '0644'
    - dir_mode: '0755'
    - clean: False
    - require:
      - file: nginx_snippets_dir

# Manage the Nginx Service
nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - pkg: install_nginx
    # This prevents Salt from breaking Nginx if a config is bad
    - check_cmd:
      - /usr/sbin/nginx -t
# Dynamically include the personality sites based on the 'host' grain
include:
  - personality.{{ grains['host'] }}.sites

# /srv/salt/hardening/nginx_selinux.sls

allow_nginx_network_connect:
  selinux.boolean:
    - name: httpd_can_network_connect
    - value: True
    - persist: True

# Ensure the nginx user/group exists first
nginx_user:
  user.present:
    - name: nginx
    - system: True
    - shell: /sbin/nologin

# Manage the log directory ownership and permissions
/var/log/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: '0755'
    - recurse:
      - user
      - group
    - seltype: httpd_log_t
