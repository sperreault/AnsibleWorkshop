# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
ansible_workshop_nodes = [{:hostname => "centos1", :ip => "192.168.33.51"}, {:hostname => "centos2", :ip => "192.168.33.52"}]
domain = "example.com"
vagrantbox = "centos/7"
shell_provision = File.read("provision.sh")
Vagrant.configure("2") do |config|
  ansible_workshop_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
     node_config.vm.box = "#{vagrantbox}"
     node_config.vm.host_name = "#{node[:hostname]}.#{domain}"
     node_config.vm.provider :virtualbox do |vb|
       node_config.vm.network "private_network", ip: "#{node[:ip]}", virtualbox__intnet: true
     end
     node_config.vm.provider :libvirt do |libvirt|
       node_config.vm.network "private_network", ip: "#{node[:ip]}"
     end
     node_config.vm.synced_folder ".", "/vagrant", disabled: true
     if "#{node[:hostname]}" == 'centos1'
       node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
       end
       node_config.vm.provider :libvirt do |libvirt|
        libvirt.memory = 2048
        libvirt.cpus = 2
       end

     else
       node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
       end
       node_config.vm.provider :libvirt do |libvirt|
        libvirt.memory = 1024
       end
     end
     node_config.vm.provision "shell",
      inline: "#{shell_provision}"
     end
  end
end
