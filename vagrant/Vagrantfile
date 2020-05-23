# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.box_version ='201912.14.0'
  config.vm.hostname = 'k8s-dev'
  config.vm.define vm_name = 'k8s'

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    set -e -x -u
    export DEBIAN_FRONTEND=noninteractive

    #change the source.list
    sudo apt-get update
    sudo apt-get install -y vim git cmake build-essential tcpdump tig jq socat bash-completion
    # Install Docker
    export DOCKER_VERSION="5:19.03.5~3-0~ubuntu-bionic"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce=${DOCKER_VERSION}
    sudo usermod -aG docker $USER

    #Disable swap
    #https://github.com/kubernetes/kubernetes/issues/53533
    sudo swapoff -a && sudo sysctl -w vm.swappiness=0
    sudo sed '/vagrant--vg-swap/d' -i /etc/fstab

    git clone https://github.com/hwchiu/hiskio-course.git

    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    bash ~/.bash_it/install.sh -s

  SHELL

  config.vm.network :private_network, ip: "172.17.8.111"
  config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--cpus", 2]
      v.customize ["modifyvm", :id, "--memory", 4096]
      v.customize ['modifyvm', :id, '--nicpromisc1', 'allow-all']
  end
end
