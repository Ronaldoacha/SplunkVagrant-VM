Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.network "forwarded_port", guest: 8000, host: 8001
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "14096"
    vb.cpus = 14
  end
  
  # Provisioning
  config.vm.provision "shell", path: "provision-splunk.sh"
end
