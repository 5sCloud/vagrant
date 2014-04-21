node-repo:
{% if grains['os'] == 'Ubuntu' %}
  pkgrepo.managed:
    - ppa: chris-lea/node.js
    - require_in:
      - pkg: nodejs
{% endif %}

nodejs:
  pkg.latest:
    - name: nodejs
