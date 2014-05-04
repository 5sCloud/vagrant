dev-hosts:
  host.present:
    - ip: 127.0.0.1
    - names:
      - {{ pillar['hostnames']['www'] }}
      - {{ pillar['hostnames']['api'] }}
      - {{ pillar['hostnames']['cdn'] }}
