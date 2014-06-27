VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define 'master' do |master|
    master.vm.box      = 'centos-65-x64-salt'
    master.vm.box_url  = 'https://dl.dropbox.com/s/j1z6qdg92eyidu4/centos-65-x64-salt.box'
    master.vm.hostname = 'master.localdomain'

    master.vm.network "private_network", ip: "192.168.234.10"

    master.vm.synced_folder "salt/conf/master.d", "/etc/salt/master.d"
    master.vm.synced_folder "salt/conf/minion.d", "/etc/salt/minion.d"
    master.vm.synced_folder "salt/reactor", "/srv/salt/reactor"
    master.vm.synced_folder "salt/states", "/srv/salt/states"
    master.vm.synced_folder "salt/pillars", "/srv/salt/pillars"

    master.vm.provider :virtualbox do |vb|
      vb.gui  = true
      vb.name = 'Salt Master'
      vb.customize ['modifyvm', :id, '--memory', '512']
    end

    master.vm.provision "shell", inline: "service salt-master start"
    master.vm.provision "shell", inline: "service salt-minion start"
  end

  config.vm.define 'buildserver' do |buildserver|
    buildserver.vm.box      = 'centos-65-x64-salt'
    buildserver.vm.box_url  = 'https://dl.dropbox.com/s/j1z6qdg92eyidu4/centos-65-x64-salt.box'
    buildserver.vm.hostname = 'buildserver.localdomain'

    buildserver.vm.network "private_network", ip: "192.168.234.20"
    buildserver.vm.network "forwarded_port", guest: 4516, host: 4516  # XL Deploy
    buildserver.vm.network "forwarded_port", guest: 5516, host: 5516  # XL Release
    buildserver.vm.network "forwarded_port", guest: 8080, host: 8080  # Jenkins

    buildserver.vm.synced_folder "salt/conf/minion.d", "/etc/salt/minion.d"

    buildserver.vm.provider :virtualbox do |vb|
      vb.gui  = true
      vb.name = 'Buildserver'
      vb.customize ['modifyvm', :id, '--memory', '2048']
    end

    buildserver.vm.provision "shell", inline: "service salt-minion start"
  end

end
