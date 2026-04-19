include:
  - nginx
# Install the ModSecurity library and Nginx module
install_modsec_packages:
  pkg.installed:
    - pkgs:
      - libmodsecurity
      - nginx-mod-modsecurity
      - mod_security_crs

# Global toggle for all Nginx sites
/etc/nginx/conf.d/modsecurity.conf:
  file.managed:
    - contents: |
        # Global ModSecurity Configuration
        modsecurity on;
        modsecurity_rules_file /etc/nginx/modsec/main.conf;
        # Test for a simple XSS attempt in the URL
        # curl -I "http://159.203.56.209/loadTest/?test=<script>alert('hack')</script>"
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: nginx_service

# Ensure the configuration directory exists
/etc/nginx/modsec:
  file.directory:
    - user: root
    - group: root
    - mode: 755

# Deploy the main ModSecurity configuration
/etc/nginx/modsec/modsecurity.conf:
  file.managed:
    - source: salt://nginx/mod_security/modsecurity.conf.j2 # Matched your pwd path
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/nginx/modsec

# Deploy the rule loader
/etc/nginx/modsec/main.conf:
  file.managed:
    - contents: |
        Include /etc/nginx/modsec/modsecurity.conf
        Include /etc/httpd/modsecurity.d/crs-setup.conf
        Include /etc/httpd/modsecurity.d/local_rules/*.conf
    - require:
      - pkg: install_modsec_packages

# Ensure the log file exists and Nginx can write to it
/dev/shm/modsec:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 755
/dev/shm/modsec/modsec_audit.log:
  file.managed:
    - user: nginx
    - group: nginx
    - mode: 644
    - replace: False # Don't overwrite if it exists

# Ensure the RAM-disk storage for IP collections exists
/dev/shm/modsec/storage:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 700
    - makedirs: True
# Ensure unicode.mapping is present (adjust source path if needed)
/etc/nginx/modsec/unicode.mapping:
  file.managed:
    - source: /etc/nginx/unicode.mapping
    - user: root
    - group: root
    - mode: 644
    - onlyif: test -f /etc/nginx/unicode.mapping

