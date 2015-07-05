# -*- mode: ruby -*-
# vi: set ft=ruby :


# ==========================================
# Getting parent host gateway for network
# config inside the box
#
# /!\ Be carefull works only on windows like 
# this.
# ==========================================
#PARENT_HOST_NETWORK_GATEWAY = %x{ route print | findstr /r "0\.0\.0\.0  *0\.0\.0\.0" }[/0\.0\.0\.0 +0\.0\.0\.0 +([0-9.]+)/, 1]


# ==========================================
# Virtual host configuration
# ==========================================
Vagrant.configure("2") do |config|


  # -----------------------------------
  # OS choosen on the machine
  # -----------------------------------
  config.vm.box = "AlbanMontaigu/boot2docker"


  # -----------------------------------
  # Server Hardware 
  # -----------------------------------
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end
  

  # -----------------------------------
  # Bridge required on second adapter in some network issue cases
  # See provision.sh to have custom network configuration
  # -----------------------------------
  #config.vm.network "public_network", auto_config: false


  # -----------------------------------
  # All internal services exposed
  # -----------------------------------
  config.vm.network "forwarded_port", guest: 22, host: 22, auto_correct: true
  # Sample for MySQL
  #config.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true
  
  
  # -----------------------------------
  # Customization of the OS
  # -----------------------------------
  #config.vm.provision "shell", path: "boot2docker/config/provision.sh", args: PARENT_HOST_NETWORK_GATEWAY
  config.vm.provision "shell", path: "boot2docker/config/provision.sh"
  
  
end

