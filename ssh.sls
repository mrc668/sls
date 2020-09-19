ssh:
  pkg:
    - installed
    {% if grains['os'] == 'CentOS' or grains['os'] == 'RedHat' %}
    - name: openssh-server
    {% endif %}
  service: 
    {% if grains['os'] == 'CentOS' or grains['os'] == 'RedHat' %}
    - name: sshd
    {% endif %}
    - running
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    {% if grains['localhost'] == 'unibasegw' 
    or grains['localhost'] == 'mrcdesktop'  %}
      - source: salt://managedFiles/sshd_config_passwords
    {% else  %}
      - source: salt://managedFiles/sshd_config
    {% endif %}
    - user: root
    - group: root
    - mode: 644

/root/.ssh:
  file.directory:
    - user: root
    - group: root
    - mode: 700

/root/.ssh/authorized_keys:
  file.managed:
    - source: salt://managedFiles/authorized_keys
    - user: root
    - group: root
    - mode: 600


