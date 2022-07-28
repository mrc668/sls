/var/lib/docker:
  file.directory:
    - user: docker
    - group: docker
    - mode: 755

/var/lib/docker/compose:
  file.directory:
    - user: docker
    - group: docker
    - mode: 755

