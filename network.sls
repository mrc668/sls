# documentation: https://docs.saltproject.io/en/latest/ref/states/all/salt.states.network.html

pkg.NetworkManager:
  pkg.installed:
    - name: NetworkManager
    - pkg_verify: true

unmask.NetworkManager:
  service.unmasked:
    - name: NetworkManager

enable.NetworkManager:
  service.enabled:
    - name: NetworkManager

start.NetworkManager:
  service.running:
    - name: NetworkManager
    - enable: true
    - unmaskFalse: true
    - unmask_runtimeFalse: true

include:
  - personality/{{ grains['nodename']}}/network

