Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-16.04"
	config.vm.hostname = "cs423-dev"
	config.vm.provider "virtualbox" do |v|
		v.name = "CS 423"
		v.cpus = "2"
		v.memory = "4096"
	end
        config.vm.synced_folder "ericsz2", "/home/vagrant/modules"
	config.vm.provision :shell, path: "provision.sh"
end
