Vagrant configuration for M5S
====

- Download and install VirtualBox ([virtualbox.org](https://www.virtualbox.org/wiki/Downloads "Download VirtualBox"))
- Download and install Vagrant ([vagrantup.com](http://www.vagrantup.com/downloads.html "Download Vagrant"))
- Once installed install the vagrant-shell-commander plugin:

        vagrant plugin install vagrant-shell-commander

- Create a symlink to the project folder named `project` into the Vagrantfile folder. Ex:

        ln -s /home/foo/projects/m5s ./project

- `vagrant up`
- Optionally modify your `/etc/hosts` file. Ex:

        ...
        192.168.33.22    m5s.local api.m5s.local static.m5s.local
        ...

