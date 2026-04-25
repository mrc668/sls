# /srv/salt/mod_security/init.sls

include:
  - nginx

# 1. Install necessary packages
install_modsec_packages:
  pkg.installed:
    - pkgs:
      - libmodsecurity
      - nginx-mod-modsecurity
      - mod_security_crs

# 2. The Main Configuration File
# This file will now contain BOTH the engine settings (via Jinja) 
# and the Include statements for the OWASP rules.
/etc/nginx/modsecurity.conf:
  file.managed:
    - source: salt://nginx/mod_security/modsecurity.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - pkg: install_modsec_packages

# 3. Global Nginx Toggle
# Tells Nginx to use the specific file we managed above.
/etc/nginx/conf.d/modsecurity.conf:
  file.managed:
    - contents: |
        # Global ModSecurity Configuration
        modsecurity on;
        modsecurity_rules_file /etc/nginx/modsecurity.conf;
    - user: root
    - group: root
    - mode: '0644'
    - watch_in:
      - service: nginx_service

# 4. Log & Storage Directories (RAM-disk)
/var/lib/nginx/modsec/:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: '0700'
    - makedirs: True

/var/log/nginx/modsec_audit.log:
  file.managed:
    - user: nginx
    - group: nginx
    - mode: '0644'
    - replace: False

