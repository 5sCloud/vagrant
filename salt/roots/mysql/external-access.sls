mysql-root:
    mysql_user.present:
        - name: root
        - allow_passwordless: True
        - host: "%"
        - require:
            - pkg: percona-server
            - pkg: pymysql

    mysql_grants.present:
        - grant: all privileges
        - database: "*.*"
        - user: root
        - host: "%"
        - require:
            - mysql_user: mysql-root

mysql-external-access:
    file.comment:
        - name: /etc/mysql/my.cnf
        - regex: ^bind-address
        - char: "#"
        - require:
            - pkg: percona-server
    service:
        - name: mysql
        - running
        - reload: True
        - watch:
            - file: mysql-external-access
