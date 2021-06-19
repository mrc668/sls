
restartSaltMinion:
  cmd.run:
    - bg: true
    - name: 'salt-call service.restart salt-minion'
    - cwd: /

