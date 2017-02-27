#*****************************************************************************#
#* Automatically install required Vagrant plugins.
#*  hostmanager - add hdfs to /etc/hosts. Needed to make the HDFS GUI download
#*                links work.
#*****************************************************************************#
required_plugins = %w( vagrant-hostmanager )
required_plugins.each do |plugin|
  exec "vagrant plugin install #{plugin} && vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  #***************************************************************************#
  #* Ensure we start with enough memory
  #***************************************************************************#
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  #***************************************************************************#
  #* Add custom hdfs entry to /etc/hosts to fix HDFS GUI download links.
  #***************************************************************************#
  config.hostmanager.enabled     = true
  config.hostmanager.manage_host = true
  config.hostmanager.aliases     = "hdfs"

  #***************************************************************************#
  #* Port forwarding for StreamSets
  #***************************************************************************#
  config.vm.network "forwarded_port", guest: 18630, host: 18630

  #***************************************************************************#
  #* Port forwarding for Hadoop
  #***************************************************************************#
  config.vm.network "forwarded_port", guest: 50070, host: 50070
  config.vm.network "forwarded_port", guest: 50075, host: 50075

  #***************************************************************************#
  #* Setup docker
  #***************************************************************************#
  config.vm.provision "shell", path: "host/install.sh", name: "Installing docker"

  #***************************************************************************#
  #* Start up the containers
  #***************************************************************************#
  config.vm.provision "shell",
    inline: "cd /vagrant ; docker-compose up -d",
    name: "Starting docker containers"
end
