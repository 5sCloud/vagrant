# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
unless Vagrant.has_plugin?("vagrant-shell-commander")
  raise 'vagrant-shell-commander is not installed! Use "vagrant plugin install vagrant-shell-commander" to install it!'
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu-trusty64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.hostname = "na-vagrant-webserver-dev"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.22"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
  if Vagrant::Util::Platform.windows?
    config.vm.synced_folder "./project", "/var/www/m5s", type: "smb"
  else
    config.vm.synced_folder "./project", "/var/www/m5s", nfs: true
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1"]
  end

  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  config.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion"
      salt.run_highstate = true

      salt.verbose = true
      salt.pillar({
        "hostnames" => {
          "www" => "m5s.local",
          "api" => "api.m5s.local",
          "cdn" => "static.m5s.local",
        },
        "log_name" => "m5s",
        "project_folder" => "/var/www/m5s"
      })
  end

  config.sh.after_share_folders = "
    sudo mount -t ramfs -o mode=0777 none /var/www/m5s/app/cache ;
    sudo mount -t ramfs -o mode=0777 none /var/www/m5s/app/logs ;
    sudo mount -t ramfs -o mode=0777 none /var/www/m5s/web/cache ;
    sudo service nginx restart
  "
end
