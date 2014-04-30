base:
  'os:Ubuntu':
    - match: grain
    - ubuntu

  'roles:webserver':
    - match: grain
    - webserver
    - webserver.php
    - imagemagick
    - node
    - node.node-less

  'roles:mysql':
    - match: grain
    - mysql

  'roles:elasticsearch':
    - match: grain
    - java-jre
    - elasticsearch

  '*':
    - openssl
    - timezone

dev:
  'roles:dev':
    - match: grain
    - nfs
    - git
    - mysql.pymysql
    - mysql.phpmyadmin
    - mysql.external-access
    - webserver.php-dev
    - ruby
    - capifony
    - composer