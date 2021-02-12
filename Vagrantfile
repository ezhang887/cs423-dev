$script = <<-'SCRIPT'

APT_FLAGS="-qq -y -o Dpkg::Use-Pty=0"
apt-get $APT_FLAGS update
apt-get $APT_FLAGS install -y git vim tmux build-essential

SCRIPT

Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-16.04"
	config.vm.hostname = "cs423-dev"
	config.vm.provider "virtualbox" do |v|
		v.name = "CS 423"
		v.cpus = "2"
		v.memory = "4096"
	end

	config.vm.provision "shell", inline: $script
end
