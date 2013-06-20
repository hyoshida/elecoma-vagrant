# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  # Host only networks
  config.vm.network :hostonly, "10.11.12.13"

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #
  #config.vm.provision :chef_solo do |chef|
  #  chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"
  #  chef.add_recipe "vagrant_main"
  #end

  config.vm.customize do |vm|
    vm.memory_size = 1024 
  end
end
