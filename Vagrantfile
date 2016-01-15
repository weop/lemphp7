Vagrant.configure("2") do |config|

  #boxinfo
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "lemphp7.localhost"
  config.vm.network :private_network, ip: "192.168.11.22"

  #forwarded ports
  config.vm.network :forwarded_port, host: 8888, guest: 80
  config.vm.network :forwarded_port, host: 3306, guest: 3306

  #starts provision
  config.vm.provision "run", type: "shell" do |s|
    s.privileged = false
    s.path = "puppet/ban.sh"
  end

  #provision puppet
  config.vm.provision :puppet do |puppet|
    puppet.facter = {
      "hostname" => "php7dev.localhost"
    }
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path = 'puppet/modules'
    puppet.manifest_file = 'init.pp'
  end

  #ends provision
  config.vm.provision "end", type: "shell" do |s|
    s.privileged = false
    s.path = "puppet/end.sh"
  end
end
