elasticsearch:
  pkg.installed:
    - sources:
{% if grains['os_family'] == 'Debian' %}
      - elasticsearch: https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.3.deb
{% endif %}
    - require:
{% if grains['os'] == 'Ubuntu' %}
      - cmd: java-jre
{% else %}
      - pkg: java-jre
{% endif %}

es-restart:
  service:
    - name: elasticsearch
    - running
    - enable: true
    - require:
      - pkg: elasticsearch

{% if 'dev' in grains['roles'] %}
elasticsearch-config-yml:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://elasticsearch/config-dev.yml
    - mode: '0644'
    - require:
      - pkg: elasticsearch
    - watch_in:
      - service: es-restart
elasticsearch-settings:
  file.managed:
    - name: /etc/default/elasticsearch
    - source: salt://elasticsearch/settings-dev
    - mode: '0644'
    - require:
      - pkg: elasticsearch
    - watch_in:
      - service: es-restart
{% endif %}
