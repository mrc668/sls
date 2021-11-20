# Install instructions:
# https://phoenixnap.com/kb/install-elk-stack-centos-8

include:
  - sls/elk/setup
  - sls/elk/elastic
  - sls/elk/kibana
  - sls/elk/logstash
  - sls/elk/beats

