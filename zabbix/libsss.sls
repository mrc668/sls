zabbix.sudo.dependancies: 
  pkg.installed:
    - pkgs:
      - libsss_sudo
      - sssd-client

not.in.nsswitch:
  cmd.run:
    - name: sed -e "s/ sss / /" -i /etc/nsswitch.conf

