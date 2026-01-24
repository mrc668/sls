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

# Deploy the global SSL policy snippet
deploy_ssl_policy:
  file.managed:
    - name: /etc/nginx/snippets/ssl_policy.conf
    - source: salt://nginx/snippets/ssl_policy.conf
    - user: root
    - group: root
    - mode: 644
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
