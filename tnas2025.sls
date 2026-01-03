{%- set nas_ip = '10.0.10.16' %}
# Test connectivity to the NFS port (2049) which is more reliable than ICMP ping
{%- set nas_available = salt['network.connect'](nas_ip, port=2049, timeout=3)['result'] %}

tnas.pkgs:
  pkg.installed:
    - pkgs:
      - nfs-utils

/nas2025:
  file.directory:
    - user: root
    - group: users
    - mode: 777

{%- if nas_available %}
/nas2025/public_dir:
  file.directory:
    - name: /nas2025/public
    - user: root
    - group: users
    - mode: 777

/nas2025/public_mount:
  mount.mounted:
    - name: /nas2025/public
    - fstype: nfs
    - device: {{ nas_ip }}:/Volume1/public
    - mkmnt: True
    - opts:
      - defaults
      - _netdev  # Critical: tells systemd this is a network device
      - nofail   # Recommended: prevents boot hang if NAS is down
    - require:
      - pkg: tnas.pkgs
      - file: /nas2025/public_dir
{%- else %}
nas_unavailable_warning:
  test.configurable_test_state:
    - name: "NAS at {{ nas_ip }} is unreachable"
    - changes: False
    - result: True
    - comment: "Skipping mount to prevent Salt timeout. Check network or NAS status."
{%- endif %}
