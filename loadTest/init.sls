# Install the benchmarking and network tools
performance_tools:
  pkg.installed:
    - pkgs:
      - httpd-tools
      - iperf3  # Rocky 9 uses iperf3 by default
      - siege
# 1. Ensure Python 3 and Pip are installed via DNF
ensure_python3_installed:
  pkg.installed:
    - pkgs:
      - python3
      - python3-pip
      - python3-devel  # Often needed for compiling Locust extensions

# 2. Install Locust using the pip provider
# Salt will use 'pip3' automatically if it's the default
install_locust:
  pip.installed:
    - name: locust
    - require:
      - pkg: ensure_python3_installed

loadTestScripts:
  file.recurse:
    - name: /usr/local/sbin
    - source: salt://loadTest/bin
    - user: root
    - group: root
    - file_mode: 0755

