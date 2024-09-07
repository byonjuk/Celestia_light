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

# Update PATH
print_color "33" "Updating PATH"
update_bashrc() {
    grep -qxF "$1" ~/.bashrc || echo "$1" >> ~/.bashrc
}
update_bashrc 'export GOROOT=/usr/local/go'
update_bashrc 'export PATH=$PATH:$GOROOT/bin'
update_bashrc 'export GOPATH=$HOME/go'
update_bashrc 'export PATH=$PATH:$GOPATH/bin'
source ~/.bashrc


print_color "36" "making celestia-light.service file"
sudo tee /etc/systemd/system/celestia-light.service > /dev/null <<EOF
[Unit]
Description=celestia-bridge Cosmos daemon
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/celestia light start --core.ip rpc.celestia.pops.one --core.rpc.port 26657 --core.grpc.port 9090 --keyring.keyname my_celes_key --metrics.tls=true --metrics --metrics.endpoint otel.celestia.observer
Restart=on-failure
RestartSec=3
LimitNOFILE=100000

[Install]
WantedBy=multi-user.target
EOF

print_color "36" "make build && make install"
cd $HOME/celestia-node
make clean
make build
sudo make install

print_color "36" "celestia light config-update --p2p.network celestia"
celestia light config-update --p2p.network celestia

print_color "36" "starting light-node"
sudo systemctl daemon-reload
sudo systemctl enable celestia-light
sudo systemctl start celestia-light

print_color "36" "AUTH_TOKEN1"
AUTH_TOKEN=$(celestia light auth admin --p2p.network celestia)

print_color "36" "AUTH_TOKEN2"
curl -X POST \
     -H "Authorization: Bearer $AUTH_TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
     http://localhost:26658
print_color "36" "celestia version"
celestia version

check_containers() {
    print_color "36" "celestia version"
    celestia version

    print_color "36" "celestia version 밑에 뜨는 문구 확인해 보삼"
    read_color "36" "celestia version이 0.15.1로 뜨는 게 맞을까요? (yes/no): " answer

    case $answer in
        [Yy]* ) 
            return 0
            ;;
        [Nn]* ) 
            print_color "32" "Waiting for 5 seconds before checking again..."
            sleep 5
            return 1
            ;;
        * ) 
            print_color "32" "Please answer yes or no."
            return 1
            ;;
    esac
}

# Main loop
attempts=0
max_attempts=2

while [ $attempts -lt $max_attempts ]
do
    if check_containers; then
        break
    fi
    attempts=$((attempts+1))
done

if [ $attempts -eq $max_attempts ]; then
    print_color "31" "celestia version이 제대로 안 뜨는 것 같다?"
    print_color "31" "카톡방에 제가 올려 둔 가이드대로 업데이트 따로 해보세욤. 근데 안 뜰 수가 없음 ㅉ"
	exit 1
fi

print_color "35" "조금만 기다려줘~" 
sleep 10

print_color "36" "상태창 띄워드릴게용~"
sudo systemctl status celestia-light --no-pager

print_color "35" "이후 'screen -S Celestia_logs' 쳐서 'sudo journalctl -u celestia-light -f' 입력 후에 로그가 제대로 나오는지 확인"
print_color "34" "로그가 주르륵 올라오면 컨트롤 A + D 를 눌러서 스크린에서 탈출해 보세요"

exec bash