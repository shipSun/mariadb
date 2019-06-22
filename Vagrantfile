Vagrant.configure("2") do |config|
  config.vm.define "mariadb" do | mariadb_1 |
	mariadb_1.vm.box = "mariadb"
	
	mariadb_1.vm.network "private_network", ip: "192.168.56.12"
	
	mariadb_1.vm.hostname = "mariadb1"
	
	mariadb_1.vm.provider "virtualbox" do | vb |
		vb.memory = "512"
		vb.cpus = 1
		vb.gui = false
	end
	mariadb_1.vm.provision "shell", path:"./mariadb.sh"
	mariadb_1.vm.provision "shell", inline: "service mariadb start", run: "always"
  end
end
