# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.define "web1" do |web1|
    web1.vm.box = "base"
    web1.vm.network :forwarded_port, host: 8080, guest: 80
  end

  config.vm.define "web2" do |web2|
    web2.vm.box = "base"
    web2.vm.network :forwarded_port, host: 8081, guest: 80
  end


end
