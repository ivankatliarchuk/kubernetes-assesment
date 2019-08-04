# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
# CPU and RAM can be adjusted depending on your system
CPUCOUNT = "2"
RAM = "4096"
UBUNTUVERSION = "18.04"

$script_sudo = <<SCRIPT
# Get the ARCH
echo "run as > $(whoami)"
ARCH="$(uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|')"
# Install Prereq Packages
export DEBIAN_PRIORITY=critical
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true
APT_OPTS="--assume-yes --no-install-suggests --no-install-recommends -o Dpkg::Options::=\"--force-confdef\" \
  -o Dpkg::Options::=\"--force-confold\""
echo "Upgrading packages ..."
apt-get update ${APT_OPTS}
apt-get dist-upgrade ${APT_OPTS}
# apt-get upgrade ${APT_OPTS}
echo "Installing prerequisites ..."
apt-get install -qqy  \
  apt-utils gcc openssh-client bash-completion gnupg gnupg2 netcat \
  build-essential curl git-core lsb-release \
  libpcre3-dev mercurial pkg-config zip \
  file vim ruby wget \
  python-setuptools python-dev python3 python3-pip && pip3 install -U crcmod && pip3 install -r /vagrant/requirements.txt
export CLOUD_SDK_VERSION=255.0.0
export CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-get update
apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 kubectl &&
  gcloud config set core/disable_usage_reporting true &&
  gcloud config set component_manager/disable_update_check true && \
  gcloud --version
echo "Updated"
# echo 'export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"' >> ~/.bash_profile
sudo chown -R vagrant /usr/local/bin
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "workstation"
  config.vm.box_check_update = false
  config.ssh.forward_agent = true

  # Don't attempt to update Virtualbox Guest Additions (requires gcc)
  if Vagrant.has_plugin?('vagrant-vbguest') then
    config.vbguest.auto_update = false
  end

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :machine
  end

  config.vm.provision "system-setup", type: "shell", inline: $script_sudo, privileged: true
  config.vm.provision "user-setup", type: "shell", path: "bin/initial-setup.sh" , privileged: false

  config.vm.synced_folder "~/.config/gcloud", "/home/vagrant/.config/gcloud", owner: 'vagrant'
  config.vm.provision "prepare-shell", type: 'shell', privileged: false, inline: <<-SHELL
    sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile
    sudo chown -R $(whoami):$(whoami) ~/.config
    sudo chown -R $(whoami):$(whoami) ~/.cache
    sudo chown -R $(whoami):$(whoami) ~/.ssh
    pip3 install -r /vagrant/inventory/requirements.txt
  SHELL

  %w(.vimrc .gitconfig).each do |f|
    local = File.expand_path "templates/vagrant/#{f}"
    if File.exist? local
      config.vm.provision "file", source: local, destination: f
    end
  end
  # Copy google cloud credentials file. TODO: encrypt it
  # config.vm.provision "file", source: ENV['GCLOUD_TF_CREDS'], destination: "/home/vagrant/.config/gcloud/#{ENV['PROJECT_ID']}-terraform-admin.json"

  config.vm.network :private_network, ip: "10.10.10.10"
  # forwarded ports only works for newly created docker contaieners
  config.vm.network :forwarded_port, guest: 80, host: 8081
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 443, host: 8443
  config.vm.network :forwarded_port, guest: 8001, host: 8001
  config.vm.network :forwarded_port, guest: 9090, host: 9090
  config.vm.network :forwarded_port, guest: 9090, host: 9090
  config.vm.network :forwarded_port, guest: 9091, host: 9091
  config.vm.network :forwarded_port, guest: 9092, host: 9092

  # config.vm.provider :docker do |v, override|
  #   override.vm.box = "tknerr/baseimage-ubuntu-#{UBUNTUVERSION}"
  #   override.vm.box_version = "1.0.0"
  #   # proxy to get port forwarding working
  #   v.ports = [ "10800:10800" ]
  #   v.ports = [ "8080:80" ]
  #   v.ports = [ "8080:8080" ]
  #   v.ports = [ "8443:443" ]
  #   v.ports = [ "443:8443" ]
  #   v.ports = [ "9090:9090" ]
  #   v.ports = [ "9091:9091" ]
  # end

  config.vm.provider :virtualbox do |v, override|
    override.vm.box = "bento/ubuntu-#{UBUNTUVERSION}"
    v.memory = "#{RAM}"
    v.cpus = "#{CPUCOUNT}"
  end

  config.vm.post_up_message="Setup complete `vagrant ssh` to ssh into the box"

end