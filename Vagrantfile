# -*- mode: ruby -*-
# vi: set ft=ruby :

PREFIX = 'n'

HOSTS = {
    "#{PREFIX}01" => '172.28.128.3',
    "#{PREFIX}02" => '172.28.128.4',
    "#{PREFIX}03" => '172.28.128.5',
    "#{PREFIX}04" => '172.28.128.6',
    "#{PREFIX}05" => '172.28.128.7',
}

Vagrant.configure(2) do |config|
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    v.customize [ "modifyvm", :id, "--natdnshostresolver1", "on" ]
    v.customize [ "modifyvm", :id, "--natdnsproxy1", "on" ]
    v.customize [ "modifyvm", :id, "--nictype1", "virtio" ]
    v.customize [ "modifyvm", :id, "--nictype2", "virtio" ]
    v.customize [ "modifyvm", :id, "--ioapic", "on" ]
    v.customize [ "modifyvm", :id, "--rtcuseutc", "on" ]
    v.customize [ "modifyvm", :id, "--clipboard", "bidirectional" ]
   end

  config.vm.box = 'debian/jessie64'

  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbooks/docker.yml'
    ansible.verbose = "vvv" if ENV['VERBOSE']

    ansible.groups = {
        "leader"   => ["#{PREFIX}01"],
        "follower" => ["#{PREFIX}02", "#{PREFIX}03", "#{PREFIX}04", "#{PREFIX}05"],
        "swarm"    => ["#{PREFIX}01", "#{PREFIX}02", "#{PREFIX}03", "#{PREFIX}04", "#{PREFIX}05"],
    }
  end

  HOSTS.each do |hostname, ip|
    config.vm.define hostname do |box|
      box.vm.network "private_network", ip: ip
    end
  end
end
