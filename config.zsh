#!/bin/zsh

packs=("zsh" "git" "erlang" "elixir" "vim")

echo "Instalando ${packs[@]} ..."

sudo add-apt-repository -y ppa:rabbitmq/rabbitmq-erlang
sudo apt update
sudo apt upgrade -y
sudo apt install -y ${packs[@]}

RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Instalando Go ..."
sudo rm -rf /usr/local/go
wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
rm go1.22.1.linux-amd64.tar.gz

echo 'export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin' >> ~/.zshrc
source ~/.zshrc

echo "Versão do Go instalada:"
go version

echo "Instalando Java"
wget https://download.oracle.com/java/24/latest/jdk-24_linux-x64_bin.tar.gz
sudo tar -C /usr/local -xzf jdk-24_linux-x64_bin.tar.gz
rm jdk-24_linux-x64_bin.tar.gz

echo 'export JAVA_HOME=/usr/local/jdk-24' >> ~/.zshrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.zshrc
source ~/.zshrc

echo "Verificando a versão do JDK ..."
java -version
javac -version

echo "Instalando Maven ..."
sudo apt install -y maven

echo "Instalando Docker ..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Configuração concluída!"

