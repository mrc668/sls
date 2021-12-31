#https://github.com/AlienVault-OTX/OTX-Apps-Bro-IDS
# https://github.com/EmergingThreats/bro
# https://github.com/CriticalPathSecurity/Zeek-Intelligence-Feeds


/usr/local/sbin/ZIF_Install:
  cmd.run:
      - cwd: /
      - runas: zeek

ZIF-directory:
  file.symlink:
    - name: /usr/local/zeek/share/zeek/site/Zeek-Intelligence-Feeds
    - target: /opt/zeek/share/zeek/site/Zeek-Intelligence-Feeds
    - makedirs: true

