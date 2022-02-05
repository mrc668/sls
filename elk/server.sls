# Install instructions:
# https://phoenixnap.com/kb/install-elk-stack-centos-8

elk.dependancies: 
  pkg.installed:
    - pkgs:
      - nmon
      - jq
      - java-1.8.0-openjdk

include:
  - sls/elk/setup
  - sls/elk/elastic
  - sls/elk/kibana
  - sls/elk/logstash
  - sls/beats

