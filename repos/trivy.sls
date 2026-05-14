{% set repo_enabled = salt['pillar.get']('trivy:repo:enabled', 0) %}

trivy_repo_managed:
  pkgrepo.managed:
    - name: trivy
    - humanname: Trivy repository
    - baseurl: https://aquasecurity.github.io/trivy-repo/rpm/releases/$basearch/
    - gpgcheck: 1
    - enabled: {{ repo_enabled }}
    - gpgkey: https://aquasecurity.github.io/trivy-repo/rpm/public.key
