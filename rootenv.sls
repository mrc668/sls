/root/.vimrc
  file.managed:
    - source: salt://managedFiles/vimrc
    - user: root
    - group: root
    - mode: 600

/root/.bashrc
  file.managed:
    - source: salt://managedFiles/bashrc
    - user: root
    - group: root
    - mode: 600

/root/.bash_profile
  file.managed:
    - source: salt://managedFiles/bash_profile
    - user: root
    - group: root
    - mode: 600



