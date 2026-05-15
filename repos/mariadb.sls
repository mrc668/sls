# repo_mariadb.sls
{% set mariadb_enabled = salt['pillar.get']('mariadb:repo:enabled', 0) %}

install_mariadb_repo:
  pkgrepo.managed:
    - name: mariadb
    - humanname: MariaDB
    - baseurl: https://rpm.mariadb.org/10.11/rhel9-amd64
    - gpgkey: https://rpm.mariadb.org/RPM-GPG-KEY-MariaDB
    - gpgcheck: 1
    - enabled: {{ mariadb_enabled }}

# Notes
# The reason I singled out 10.11 is that it represents the most stable "long-term" 
# intersection for your specific environment (Rocky 9 + Nextcloud).
# 
# While you correctly value the "stability through stagnation" of a distro version, 
# MariaDB 10.11 is actually the version designed specifically to provide that same 
# experience while solving three critical problems you'll face on Rocky 9.
# 
# 1. Why the Vendor Version (MariaDB.org)?
# In a "TurboTerrier" or security-focused environment, the distro version has a major 
# blind spot: The Support Gap.
# 
# Rocky 9's AppStream currently provides MariaDB 10.5.
# 
# The Problem: MariaDB 10.5 officially reached its End of Life (EOL) in June 2025.
# 
# The Risk: While Red Hat/Rocky might "backport" critical security fixes, they do not 
# backport all bug fixes. You end up running an engine that the original creators have 
# stopped working on.
# 
# The Vendor Advantage: By using the vendor repo, you get the official LTS (Long Term 
# Support) branch. You aren't getting "bleeding edge" code; you are getting the version 
# that is legally and technically committed to being the "stable workhorse" for the 
# next several years.
# 
# 2. Why 10.11 Specifically?
# I chose 10.11 over the more recent 11.x releases because of its LTS Status and Nextcloud 
# Compatibility.
# 
# It is the "Distro-Grade" LTS: MariaDB 10.11 was specifically timed to be the foundation 
# for major stable distros (like Debian 12). It is supported until February 2028.
# 
# No "New Code" Surprises: Unlike the 11.x series (which introduced a major new Optimizer 
# and "rolling" release features), 10.11 is the final, most polished version of the 10.x 
# architecture. It fixes the bugs of 10.5 and 10.6 without the architectural shifts of 11.0.
# 
# Nextcloud Performance: Nextcloud's database load is heavy on "System Versioning" and complex 
# joins. 10.11 introduced significant performance improvements for these specific types of 
# queries that simply don't exist in the 10.5 version shipped with Rocky.
# 
# 3. Stability vs. Stagnation
# You mentioned that distro versions are stable because they only fix bugs. MariaDB's LTS 
# releases (like 10.11) follow this exact same philosophy:
# 
# Once a version is marked GA (General Availability) and LTS, the vendor freezes the feature set.
# 
# Updates to 10.11.x are strictly bug and security fixes.
# 
# You get the stability you like, but on a modern codebase that actually understands the 
# hardware and NVMe drives you are likely using in 2026.
# 
