docker.dependancies:
  pkg.installed:
    - pkgs:
      - podman 
      - podman-compose
      - buildah 
      - skopeo
      - podman-docker
      - toolbox
      - curl
      - wget
      - netcat
      - telnet
      - nmap
      - yamllint
      - jq
      - python3-pip

podman.socket:
  service.running:
    - enable: true
    - reload: true
    - name: podman.socket
  file.managed:
    - name: /usr/lib/systemd/system/podman.socket
    - source: salt://sls/docker/podman.socket
    - owner: root
    - group: root 
    - mode: 644

/run/podman:
  file.directory:
    - mode: 770
    - user: root
    - group: docker


