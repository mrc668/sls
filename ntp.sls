ntp:
  pkg:
    - installed
  service: 
    {% if grains['os'] == 'CentOS' or grains['os'] == 'RedHat' %}
    - name: ntpd
    {% endif %}
    - running
    - watch:
      - file: /etc/ntp.conf
  user.present:
    - home: /etc/ntp
    - shell: /sbin/nologin

/etc/ntp.conf:
  file.managed:
    {% if grains['localhost'] == 'devil' 
    or grains['localhost'] == 'unibasegw'  %}
    - source: salt://managedFiles/ntp.conf_localtimeserver
    {% else %}
    - source: salt://managedFiles/ntp.conf
    {% endif %}
    - user: root
    - group: root
    - mode: 644


