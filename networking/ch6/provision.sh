set -e -x -u
export DEBIAN_FRONTEND=noninteractive

echo info[:ip]
#change the source.list
sudo apt-get update
sudo apt-get install -y vim git cmake build-essential tcpdump tig socat bash-completion golang libpcap-dev bridge-utils ipcalc conntrack

# Configure Docker subnet
sudo mkdir -p /etc/docker
sudo cp /tmp/daemon.json /etc/docker/daemon.json

# Install Docker
export DOCKER_VERSION="5:19.03.15~3-0~ubuntu-focal"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce=${DOCKER_VERSION}
sudo usermod -aG docker $USER

git clone https://github.com/hwchiu/hiskio-course.git

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh -s

# Install tcpterm
go get -d github.com/sachaos/tcpterm
pushd go/src/github.com/sachaos/tcpterm/
go install
popd
