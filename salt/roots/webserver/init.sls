nginx-repo:
{% if grains['os'] == 'Ubuntu' %}
  pkgrepo.managed:
    - ppa: nginx/stable
    - require_in:
      - pkg: nginx
{% endif %}

nginx:
  pkg.latest:
    - name: nginx
  service:
    - name: nginx
    - enable: true
    - running
    - require:
      - pkg: nginx

fastcgi_params:
  file.blockreplace:
    - name: /etc/nginx/fastcgi_params
    - marker_start: "# START managed zone buffer-size -DO-NOT-EDIT-"
    - marker_end: "# END managed zone buffer-size --"
    - content: |
        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
    - append_if_not_found: True
    - backup: '.bak'
    - show_changes: True

default-site:
  file.managed:
    - source: salt://webserver/nginx/sites-available/default
    - name: /etc/nginx/sites-available/default
    - mode: '0644'
    - replace: true
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx-reload

default.d-dir:
  file.touch:
    - name: /etc/nginx/sites-available/default.d/.dirkeep
    - makedirs: true
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx-reload

default.d-symlink:
  file.symlink:
    - name: /etc/nginx/sites-default.d
    - target: /etc/nginx/sites-available/default.d
    - require:
      - file: default.d-dir
    - watch_in:
      - service: nginx-reload

nginx-reload:
  service:
    - name: nginx
    - running
    - reload: true

m5s-site:
  file.managed:
    - source: salt://webserver/nginx/sites-available/m5s
    - name: /etc/nginx/sites-available/m5s
    - mode: '0644'
    - replace: true
    - template: jinja
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx-reload

m5s-enable:
  file.symlink:
    - name: /etc/nginx/sites-enabled/m5s
    - target: /etc/nginx/sites-available/m5s
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx-reload
    