capifony:
  gem.installed:
    - name: capifony
    - require:
      - pkg: ruby

capistrano-rsync:
  gem.installed:
    - name: capistrano_rsync_with_remote_cache
    - require:
      - pkg: ruby
