base:
  pkg.latest:
    - pkgs:
      - 'python-pycurl'
      - 'python-software-properties'

resolvconf:
  pkg:
    - latest
  service:
    - running
    - enable: true
    - watch:
      - file: resolvconf-base
      - file: resolvconf-head

resolvconf-base:
  file.managed:
    - name: /etc/resolvconf/resolv.conf.d/base
    - source: salt://ubuntu/resolv.conf.d/base
    - mode: 0644
    - replace: true
    - require:
      - pkg: resolvconf

resolvconf-head:
  file.managed:
    - name: /etc/resolvconf/resolv.conf.d/head
    - source: salt://ubuntu/resolv.conf.d/head
    - mode: 0644
    - replace: true
    - require:
      - pkg: resolvconf

apt-util:
  file.managed:
    - name: /usr/local/bin/apt-util
    - source: salt://ubuntu/apt-util.sh
    - mode: 0755
    - replace: true
  cmd.run:
    - name: tr -d '\015' < /usr/local/bin/apt-util > /tmp/apt-util && mv /tmp/apt-util /usr/local/bin/apt-util
    - require:
        - file: apt-util
