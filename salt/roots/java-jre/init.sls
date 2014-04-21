java-jre:
{% if grains['os'] == 'Ubuntu' %}
  cmd.run:
    - name: apt-util --installed -o "--no-install-recommends" openjdk-7-jre
    - stateful: true
{% else %}
  pkg.installed:
    - pkgs:
      - openjdk-7-jre
{% endif %}