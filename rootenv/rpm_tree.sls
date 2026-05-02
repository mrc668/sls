deploy_rpm_tree_script:
  file.managed:
    - name: /usr/local/sbin/show_rpm_tree
    - user: root
    - group: root
    - mode: '0755'
    - source: salt://rootenv/show_rpm_tree
