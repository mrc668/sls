# 1. Deploy the script itself
deploy_costctl_script:
  file.managed:
    - name: /usr/local/sbin/costctl.sh
    - source: salt://salt/master/costctl.sh
    - user: root
    - group: root
    - mode: '0755'  # Executable

# 2. Deploy the systemd unit file
deploy_cost_service_unit:
  file.managed:
    - name: /etc/systemd/system/cost-monitor.service
    - source: salt://salt/master/costctl.service
    - user: root
    - group: root
    - mode: '0644'
    - watch_in:
      - service: run_cost_monitor_service

# 3. Enable and start the service
run_cost_monitor_service:
  service.running:
    - name: cost-monitor
    - enable: True
    - require:
      - file: deploy_costctl_script
      - file: deploy_cost_service_unit
    # This ensures that if you change the script or the service file, 
    # Salt will automatically restart the service to apply changes.
    - watch:
      - file: deploy_costctl_script
      - file: deploy_cost_service_unit

