{% if grains['os_family'] == 'Debian' %}
percona-server-repo:
  pkgrepo.managed:
    - humanname: Percona PPA
    {% if grains['lsb_distrib_codename'] == 'trusty' %}
    - name: deb http://repo.percona.com/apt precise main
    {% else %}
    - name: deb http://repo.percona.com/apt {{ grains['lsb_distrib_codename'] }} main
    {% endif %}
    - dist: precise
    - file: /etc/apt/sources.list.d/percona.list
    - keyid: 1C4CBDCDCD2EFD2A
    - keyserver: keys.gnupg.net
    - require_in:
      - pkg: percona-server
{% endif %}

percona-server:
  pkg.installed:
    - pkgs:
      - percona-server-server-5.5
      - percona-server-client-5.5
  service:
    - name: mysql
    - enable: true
    - running
    - require:
      - pkg: percona-server
    