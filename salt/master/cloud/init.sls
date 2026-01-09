# Install the core salt-cloud package and the python library for DO
install_cloud_tooling:
  pkg.installed:
    - pkgs:
      - salt-cloud
      - python3-libcloud  # The engine that talks to the DO API

# Ensure the configuration directories exist with secure permissions
# These hold your tokens and blueprints
/etc/salt/cloud.providers.d:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

/etc/salt/cloud.profiles.d:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True
#
# Add this to the top of salt/master/cloud/init.sls
include:
  - digitalOcean  # This assumes digitalOcean.sls is in the same 'cloud' folder

# ... existing pkg and directory states ...
