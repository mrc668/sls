 # Springdale is not a common enough RH spin that salt recognizes it.
 # This script adds Springdale in the appropriate file so that it can install packages the RedHat way.

/usr/local/src/salt.p1:
  file.managed:
    - source: salt://sls/salt/salt.p1
    - user: root
    - group: root
    - mode: 644

/usr/local/sbin/sdlSalt.sh:
  file.managed:
    - source: salt://sls/salt/sdlSalt.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - cwd: /

