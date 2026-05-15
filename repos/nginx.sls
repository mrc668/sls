# repo_nginx.sls
{% set nginx_enabled = salt['pillar.get']('nginx:repo:enabled', 0) %}

install_nginx_repo:
  pkgrepo.managed:
    - name: nginx-stable
    - humanname: nginx stable repo
    - baseurl: http://nginx.org/packages/centos/9/$basearch/
    - gpgcheck: 1
    - enabled: {{ nginx_enabled }}
    - gpgkey: https://nginx.org/keys/nginx_signing.key
    - module_hotfixes: True

# Notes
#
# The argument for the Nginx vendor repository follows a similar logic to 
# MariaDB, but with a specific focus on security features and module compatibility—two 
# areas that are critical for your "TurboTerrier" hardening and WAF architecture.
# 
# Here is why the vendor version (nginx.org) is generally preferred over the 
# Rocky 9 AppStream version:
# 
# 1. Mainline vs. Stable
# The Nginx vendor repo gives you a choice that the distro doesn't:
# 
# Mainline: Where all new features and security enhancements happen first.
# 
# Stable: This version receives only critical bug fixes and security patches.
# Rocky 9 usually sticks to a specific version that was "stable" at the time of the OS 
# release. By using the vendor repo, you can choose the Stable branch to get the 
# "bug-fixes-only" experience you prefer, but on a version that isn't years behind.
# 
# 2. Modern TLS and HTTP/3 Support
# Nginx moves fast on security protocols.
# 
# HTTP/3 (QUIC): Support for HTTP/3 is relatively recent. Distro versions often lag 
# behind in implementing the library dependencies (like OpenSSL or BoringSSL) required 
# to run modern, faster, and more secure encryption protocols.
# 
# Security Headers: Newer versions of Nginx introduce simpler directives for managing 
# security headers and overcoming vulnerabilities like Request Smuggling.
# 
# 3. WAF and Module Compatibility (ModSecurity)
# Since you are using Nginx as a WAF with ModSecurity, the vendor version is almost 
# mandatory.
# 
# Dynamic Modules: Nginx modules must be compiled against the exact version of Nginx 
# they run on.
# 
# The Conflict: If you use the Rocky version, you are at the mercy of whatever version 
# of ModSecurity is in the EPEL repo matching that specific Rocky Nginx build.
# 
# The Solution: Using the vendor repo allows you to consistently build or pull 
# ModSecurity/OWASP Rule Set modules that are guaranteed to work with a known, standardized 
# Nginx binary.
# 
# 4. Patch Velocity
# When a high-profile vulnerability (like a Buffer Overflow or a Zero-Day) is discovered 
# in Nginx:
# 
# Vendor: A patch is usually out within hours.
# 
# Distro: The patch must be verified by the upstream (RHEL) team, then downstream (Rocky) 
# team, before it hits your dnf update. In a security-focused role, cutting out those middle 
# layers reduces your "window of exposure."
#
