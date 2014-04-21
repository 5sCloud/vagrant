php5-dev:
  pkg.installed:
    - pkgs:
      - php5-xdebug
    - watch_in:
      - service: php5-fpm-restart

xdebug-nesting-level:
  file.blockreplace:
    - name: /etc/php5/mods-available/xdebug.ini
    - marker_start: "; START managed zone xdebug-nesting-level -DO-NOT-EDIT-"
    - marker_end: "; END managed zone xdebug-nesting-level --"
    - content: "xdebug.max_nesting_level=250"
    - append_if_not_found: True
    - backup: '.bak'
    - show_changes: True
    - require:
      - pkg: php5-dev
    - watch_in:
      - service: php5-fpm-restart