openssl-heartbleed:
{% if grains['os'] == 'Ubuntu' %}
  pkg.installed:
    - pkgs:
  {% if grains['lsb_distrib_release'] == '12.04' %}
      - openssl: 1.0.1-4ubuntu5.12
  {% elif grains['lsb_distrib_release'] == '12.10' %}
      - openssl: 1.0.1c-3ubuntu2.7
  {% elif grains['lsb_distrib_release'] == '13.10' %}
      - openssl: 1.0.1e-3ubuntu1.2
  {% elif grains['lsb_distrib_release'] == '14.04' %}
      - openssl: 1.0.1f-1ubuntu2
  {% endif %}
{% endif %}
