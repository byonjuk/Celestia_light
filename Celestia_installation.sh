#!/bin/bash

#31: Red
#32: Green
#33: Yellow
#34: Blue
#35: Magenta
#36: Cyan

# Function to display colored text
print_color() {
    COLOR=$1
    TEXT=$2
    echo -e "\e[${COLOR}m${TEXT}\e[0m"
}

# Function for colored read command
read_color() {
    COLOR=$1
    PROMPT=$2
    shift 2
    echo -e "\e[${COLOR}m${PROMPT}\e[0m"
    read "$@"
}

# Function to prompt user to press any key to continue
press_any_key() {
    echo -e "\e[36mPress any key to continue...\e[0m"
    read -n 1 -s  # -n 1 reads 1 character, -s hides the input
}

# Install KOREAN

print_color "36" "Install KOREAN"

sudo apt-get install language-pack-ko -y

sudo locale-gen ko_KR.UTF-8

sudo update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX


print_color "36" "한글설치완료"

#command

print_color "32" "sudo apt update"
sudo apt update

print_color "32" "sudo apt upgrade -y"
sudo apt upgrade -y

print_color "32" "sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git ncdu make screen -y"
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git ncdu make screen -y

print_color "32" "sudo apt autoremove -y"
sudo apt autoremove -y

print_color "32" "sudo apt-get update"
sudo apt-get update

# updating go
print_color "33" "installing golang-go ..."
sudo apt remove golang-go -y
sudo apt autoremove -y
wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
rm go1.23.0.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

print_color "32" "source $HOME/.bash_profile"
source $HOME/.bash_profile

print_color "32" "go version"
go version

print_color "32" "rm -rf celestia-node"
cd $HOME
rm -rf celestia-node

print_color "32" "git clone https://github.com/celestiaorg/celestia-node.git"
git clone https://github.com/celestiaorg/celestia-node.git

print_color "32" "cd celestia-node/"
cd $HOME/celestia-node/

print_color "32" "git checkout tags/v0.16.1-rc0"
git checkout tags/v0.16.0

print_color "32" "make build"
make build

print_color "32" "sudo make install"
sudo make install

print_color "32" "make cel-key"
make cel-key

print_color "36" "'screen -S Celestia_wallet', 입력후에 'celestia light init --core.ip rpc.celestia.pops.one --p2p.network celestia' 입력"
print_color "36" "입력하고 뜨는 celestial address랑 mnemonic 24단어 무조건 저장하세요. 만약 저장 안 하셨다면 저한테 명령어 받으러 오삼..."


exec bash