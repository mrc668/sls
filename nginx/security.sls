# 1. Ensure the directory has the correct SELinux context and permissions
# This prevents Nginx from having write access to its own configuration root.
/etc/nginx:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - recurse:
      - user
      - group
      - mode

# 2. Set SELinux context for the configuration files
# httpd_sys_content_t is for read-only content.
nginx_config_selinux:
  selinux.fcontext_policy_present:
    - name: /etc/nginx(/.*)?
    - sel_type: httpd_sys_content_t

# 3. Apply the context to the filesystem (restorecon)
nginx_config_context_applied:
  selinux.fcontext_policy_applied:
    - name: /etc/nginx
    - recursive: True
    - require:
      - selinux: nginx_config_selinux

# 4. Repeat for your static web content
/var/www/html:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - recurse:
      - user
      - group
      - mode

static_content_selinux:
  selinux.fcontext_policy_present:
    - name: /var/www/html(/.*)?
    - sel_type: httpd_sys_content_t

static_content_applied:
  selinux.fcontext_policy_applied:
    - name: /var/www/html
    - recursive: True
    - require:
      - selinux: static_content_selinux

# /srv/salt/hardening/nginx_selinux.sls
allow_nginx_network_connect:
  selinux.boolean:
    - name: httpd_can_network_connect
    - value: True
    - persist: True

# Disable httpd_execmem to prevent httpd from executing programs 
# that require executable stack or making memory executable.
# Need this enabled for tarpit.
enable_httpd_execmem:
  selinux.boolean:
    - name: httpd_execmem
    - value: True
    - persist: True

