# 1. Install the "Development Tools" package group
development_tools:
  pkg.group_installed:
    - name: 'Development Tools'

# 2. Install specific RPM building requirements
rpm_build_packages:
  pkg.installed:
    - pkgs:
      - rpm-build
      - rpmdevtools
      - rpmlint
      - fedora-packager
      - spectool
      - wget
      - curl
      - git
      - createrepo_c

# 4. Optional: Install common development headers (uncomment as needed)
# extra_dev_headers:
#   pkg.installed:
#     - pkgs:
#       - openssl-devel
#       - zlib-devel
#       - libxml2-devel
# Create the dedicated build user
rpmbuild_user:
  user.present:
    - name: rpmbuild
    - home: /home/rpmbuild
    - shell: /bin/bash

# Create the storage area on the large /opt partition
opt_rpmbuild_storage:
  file.directory:
    - name: /opt/rpmbuild
    - user: rpmbuild
    - group: rpmbuild
    - mode: 755
    - makedirs: True

# Symlink the standard rpmbuild path to the large /opt partition
# This tricks 'rpmbuild' into using the big disk
rpmbuild_link:
  file.symlink:
    - name: /home/rpmbuild/rpmbuild
    - target: /opt/rpmbuild
    - user: rpmbuild
    - group: rpmbuild
    - force: True
    - require:
      - user: rpmbuild_user
      - file: opt_rpmbuild_storage

# Create the subdirectories required for building
rpm_structure:
  file.directory:
    - user: rpmbuild
    - group: rpmbuild
    - mode: 755
    - names:
      - /opt/rpmbuild/SOURCES
      - /opt/rpmbuild/SPECS
      - /opt/rpmbuild/BUILD
      - /opt/rpmbuild/RPMS
      - /opt/rpmbuild/SRPMS
      - /opt/rpmbuild/tmp
    - require:
      - file: opt_rpmbuild_storage
# Deploy the existing .gitconfig from the master
deploy_gitconfig:
  file.managed:
    - name: /home/rpmbuild/.gitconfig
    - source: salt://files/gitconfig
    - user: rpmbuild
    - group: rpmbuild
    - mode: 644
    - template: jinja  # Optional: allows you to use variables inside the files

# Deploy the existing .rpmmacros from the master
deploy_rpmmacros:
  file.managed:
    - name: /home/rpmbuild/.rpmmacros
    - source: salt://files/rpmmacros
    - user: rpmbuild
    - group: rpmbuild
    - mode: 644
    - template: jinja
