phpmyadmin:
{% if grains['os'] == 'Ubuntu' %}
  cmd.run:
    - name: apt-util --installed -o "--no-install-recommends" phpmyadmin
    - stateful: true
{% else %}
  pkg.installed:
    - pkgs:
      - phpmyadmin
{% endif %}
    - require:
      - pkg: percona-server
      - pkg: php5

allow-no-password:
  file.managed:
    - name: /etc/phpmyadmin/conf.d/nopassword.php
    - source: salt://mysql/phpmyadmin-nopassword.php
    - mode: '0644'
    - require:
{% if grains['os'] == 'Ubuntu' %}
      - cmd: phpmyadmin
{% else %}
      - pkg: phpmyadmin
{% endif %}

phpmyadmin-nginx:
  file.managed:
    - source: salt://webserver/nginx/sites-available/default.d/phpmyadmin
    - name: /etc/nginx/sites-default.d/phpmyadmin
    - mode: '0644'
    - replace: true
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx-reload
