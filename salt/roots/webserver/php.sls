{% if grains['os'] == 'Ubuntu' %}
  {% if grains['lsb_distrib_release'] <= '13.04' %}
php55-repo:
  pkgrepo.managed:
    - ppa: ondrej/php5
    - require_in:
      - pkg: php5
  {% endif %}
{% endif %}

php5:
  pkg.installed:
    - pkgs:
      - php5
      - php5-cli
      - php5-fpm
      - php5-json
      - php5-mysql
      - php5-gd
      - php5-imagick
      - php5-mcrypt
      - php5-intl

php5-fpm-restart:
  service:
    - name: php5-fpm
    - enable: true
    - running
    - require:
      - pkg: php5

{% if grains['os_family'] == 'Debian' %}
enable-mcrypt:
  cmd.run:
    - name: php5enmod mcrypt
    - unless: php5query -q -s cli -m mcrypt && php5query -q -s fpm -m mcrypt
    - require:
      - pkg: php5
    - watch_in:
      - service: php5-fpm-restart
{% endif %}

m5s-pool:
  file.managed:
    - source: salt://webserver/fpm/pool.d/m5s.conf
    - name: /etc/php5/fpm/pool.d/m5s.conf
    - mode: '0644'
    - replace: true
    - require:
      - pkg: php5
    - watch_in:
      - service: php5-fpm-restart
