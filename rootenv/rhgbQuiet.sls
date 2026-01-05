harden_grub_cmdline:
  file.replace:
    - name: /etc/default/grub
    - pattern: 'rhgb|quiet'
    - repl: ''
  cmd.run:
    - name: grub2-mkconfig -o /boot/grub2/grub.cfg
    - onchanges:
      - file: harden_grub_cmdline
