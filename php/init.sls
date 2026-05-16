{% set p_ver = salt['pillar.get']('nextcloud:php_version', '83').replace('.', '') %}

# Core PHP-FPM and required modules for Nextcloud
install_php_stack:
  pkg.installed:
    - pkgs:
      - php{{ p_ver }}-php-fpm
      - php{{ p_ver }}-php-common
      - php{{ p_ver }}-php-gd
      - php{{ p_ver }}-php-mbstring
      - php{{ p_ver }}-php-intl
      - php{{ p_ver }}-php-mysqlnd
      - php{{ p_ver }}-php-xml
      - php{{ p_ver }}-php-pecl-apcu
      - php{{ p_ver }}-php-pecl-redis5
      - php{{ p_ver }}-php-opcache
      - php{{ p_ver }}-php-bcmath
      - php{{ p_ver }}-php-gmp
    - require:
      - pkgrepo: remi_php_repo

php_fpm_service:
  service.running:
    - name: php{{ p_ver }}-php-fpm
    - enable: True
    - watch:
      - file: php_fpm_pool_config
