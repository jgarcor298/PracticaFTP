# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "server-ftp" do |server|
    server.vm.box = "bento/ubuntu-22.04"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "server-ftp"
      vb.memory = 2048
      vb.cpus = 2
    end
    server.vm.provision "shell", path: "bootstrap.sh"
    server.vm.network "private_network", ip: "192.168.56.10"
  end
end

