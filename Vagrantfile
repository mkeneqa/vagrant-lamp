# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.  
  
  config.vm.box = "ubuntu/xenial64"

  # Provider-specific configuration
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.network "forwarded_port", guest: 80, host: 8088
  config.vm.network "forwarded_port", guest: 3306, host: 33306
  
  # map shared folders
  config.vm.synced_folder "./myapp", "/var/www/myapp", :nfs => { :mount_options => ["dmode=777","fmode=666"] }  

  # move apache config files to vagrant home
  config.vm.provision "file",source:"./prepare/apache2.conf",destination:"$HOME/apache2.conf"
  config.vm.provision "file",source:"./prepare/ports.conf",destination:"$HOME/ports.conf"
  config.vm.provision "file",source:"./prepare/myapp.conf",destination:"$HOME/myapp.conf"

  config.vm.provision "shell", path: "./prepare/setup.sh"

end