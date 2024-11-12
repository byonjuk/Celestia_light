#!/bin/bash

BOLD='\033[1m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
CYAN='\033[36m'
MAGENTA='\033[35m'
NC='\033[0m'

# 한국어 체크하기
check_korean_support() {
    if locale -a | grep -q "ko_KR.utf8"; then
        return 0  # Korean support is installed
    else
        return 1  # Korean support is not installed
    fi
}

# 한국어 IF
if check_korean_support; then
    echo -e "${CYAN}한글있긔 설치넘기긔.${NC}"
else
    echo -e "${CYAN}한글없긔, 설치하겠긔.${NC}"
    sudo apt-get install language-pack-ko -y
    sudo locale-gen ko_KR.UTF-8
    sudo update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX
    echo -e "${CYAN}설치 완료했긔.${NC}"
fi

# 셀레스티아 라이트 노드 설치하기
celestia_installation() {
echo -e "${CYAN}sudo apt update${NC}"
sudo apt update

echo -e "${CYAN}sudo apt upgrade -y${NC}"
sudo apt upgrade -y

echo -e "${CYAN}sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git ncdu make screen -y${NC}"
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git ncdu make screen -y

echo -e "${CYAN}sudo apt autoremove -y${NC}"
sudo apt autoremove -y

echo -e "${CYAN}sudo apt-get update${NC}"
sudo apt-get update

# updating go
echo -e "${CYAN}installing golang...${NC}"
sudo apt remove golang-go -y
sudo apt autoremove -y
wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz
rm go1.23.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

echo -e "${CYAN}source $HOME/.bash_profile${NC}"
source $HOME/.bash_profile

echo -e "${CYAN}source $HOME/.bashrc${NC}"
source $HOME/.bashrc

echo -e "${CYAN}go version${NC}"
go version

echo -e "${CYAN}rm -rf celestia-node${NC}"
cd $HOME
rm -rf celestia-node

echo -e "${CYAN}git clone https://github.com/celestiaorg/celestia-node.git${NC}"
git clone https://github.com/celestiaorg/celestia-node.git

echo -e "${CYAN}cd $HOME/celestia-node/${NC}"
cd $HOME/celestia-node/

echo -e "${CYAN}git checkout tags/v0.16.0${NC}"
git checkout tags/v0.16.0

echo -e "${CYAN}make build${NC}"
make build

echo -e "${CYAN}sudo make install${NC}"
sudo make install

echo -e "${CYAN}make cel-key${NC}"
make cel-key

echo -e "${MAGENTA}'screen -S Celestia_wallet', 입력후에 'celestia light init --core.ip rpc.celestia.pops.one --p2p.network celestia' 입력${NC}"
echo -e "${MAGENTA}입력하고 뜨는 celestial address랑 mnemonic 24단어 무조건 저장하세요. 만약 저장 안 하셨다면 저한테 명령어 받으러 오삼...${NC}"

}

# 셀레스티아 노드 실행하기
celestia_execution() {
# Update PATH
echo -e "${CYAN}Updating PATH{NC}"
update_bashrc() {
    grep -qxF "$1" ~/.bashrc || echo "$1" >> ~/.bashrc
}
update_bashrc 'export GOROOT=/usr/local/go'
update_bashrc 'export PATH=$PATH:$GOROOT/bin'
update_bashrc 'export GOPATH=$HOME/go'
update_bashrc 'export PATH=$PATH:$GOPATH/bin'
source ~/.bashrc


echo -e "${CYAN}making celestia-light.service file${NC}"
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

echo -e "${CYAN}celestia light config-update --p2p.network celestia${NC}"
celestia light config-update --p2p.network celestia

echo -e "${CYAN}starting light-node${NC}"
sudo systemctl daemon-reload
sudo systemctl enable celestia-light
sudo systemctl start celestia-light

check_containers() {
    echo -e "${CYAN}celestia version${NC}"
    celestia version

    echo -e "${CYAN}celestia version 밑에 뜨는 문구 확인해 보삼${NC}"
    echo -ne "${CYAN}celestia version이 0.16.0로 뜨는 게 맞을까요? (yes/no): ${NC}"
    read -e answer
    case $answer in
        [Yy]* ) return 0 ;;  # 바로 리턴
        [Nn]* ) 
            echo -e "${RED}Waiting for 5 seconds before checking again...${NC}"
            sleep 5
            return 1
            ;;
        * ) 
            echo -e "${RED}Please answer yes or no.${NC}"
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
    echo -e "${BOLD}${MAGENTA}celestia version이 제대로 안 뜨는 것 같다?${NC}"
    echo -e "${BOLD}${MAGENTA}카톡방에 제가 올려 둔 가이드대로 업데이트 따로 해보세욤. 근데 안 뜰 수가 없음 ㅉ${NC}"
	exit 1
fi


echo -e "${CYAN}조금만 기다려줘${NC}" 
sleep 10

echo -e "${CYAN}상태창 띄워드릴게용~${NC}"
sudo systemctl status celestia-light --no-pager


echo -e "${BOLD}${MAGENTA}아직 끝난 거 아니에용. 다시 스크립트를 켜서 3번 입력해서 AUTH_TOKEN까지 설정해 주세요.${NC}"
echo -e "${BOLD}${MAGENTA}이후 'screen -S Celestia_logs' 쳐서 'sudo journalctl -u celestia-light -f' 입력 후에 로그가 제대로 나오는지 확인${NC}"
echo -e "${BOLD}${MAGENTA}로그가 주르륵 올라오면 컨트롤 A + D 를 눌러서 스크린에서 탈출해 보세요${NC}"
}

#AUTH_TOKEN 설정하기
AUTH_TOKEN() {
echo -e "${CYAN}이미 있는 AUTH_TOKEN 명령어 삭제하기"
unset AUTH_TOKEN

echo -e "${CYAN}AUTH_TOKEN을 설정하고 있어요. ${NC}"
AUTH_TOKEN=$(celestia light auth admin --p2p.network celestia)

echo -e "${BOLD}${MAGENTA}AUTH_TOKEN이 잘 설정됐는지 확인하기 ${NC}"
curl -X POST -H "Authorization: Bearer $AUTH_TOKEN" -H 'Content-Type: application/json' -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' http://localhost:26658

echo -e "${CYAN}잘 실행됐으니까 이제 발 닦고 잠이나 자러 가렴${NC}"
}

#셀레스티아 업데이트
celestia_update() {
echo -e "${BOLD}${MAGENTA}셀레스티아 업데이트를 시작합니다.${NC}"
echo -e "${CYAN}버젼을 업데이트 합니다.${NC}"
cd $HOME/celestia-node

git fetch --all --tags

git checkout tags/v0.17.2

echo -e "${CYAN}업데이트된 버젼을 설치합니다.${NC}"
make clean
make build
sudo make install

echo -e "${CYAN}셀레스티아를 재시작합니다.${NC}"
sudo systemctl daemon-reload
sudo systemctl start celestia-light
sudo systemctl enable celestia-light
echo -e "${CYAN}celestia version${NC}"
celestia version

echo -e "${BOLD}${CYAN}잘 돌아가는지 한 번 확인하세용${NC}"
sleep 3
sudo systemctl status celestia-light --no-pager

echo -e "${CYAN}업데이트가 완료되었습니다.${NC}"
}

check_status_of_celestia() {
echo -e "${BOLD}${CYAN}셀레스티아 상태창을 띄워드릴게요. 잘 돌아가는지 확인해 보세요~${NC}"
sudo systemctl status celestia-light --no-pager

echo -e "${BOLD}${MAGENTA}STATUS : active가 떠있니? 만약 떠있지 않다면 다시 스크립트를 실행해서 5번을 입력하도록 하렴 ♥${NC}"

}

# 셀레스티아 노드 재시작하기
restart_celestia() {
echo -e "${MAGENTA}셀레스티아 재시작 해줄게~${NC}"
sudo systemctl stop celestia-light
sudo systemctl start celestia-light
sudo systemctl enable celestia-light

echo -e "${BOLD}${CYAN}셀레스티아 상태창을 띄워드릴게요. 잘 돌아가는지 확인해 보세요~${NC}"
sudo systemctl status celestia-light --no-pager

echo -e "${BOLD}${MAGENTA}STATUS : active가 떠있니? 만약 떠있지 않다면 질문방에서 돼레이나 뵨죽한테 질문해♥${NC}"
}

#셀레스티아 노드 지워버리기.
uninstall_celestia() {
echo -e "${CYAN}sudo rm -rf $HOME/celestia-node${NC}"
sudo rm -rf $HOME/celestia-node
sudo rm -rf $HOME/.celestia-light

echo -e "${CYAN}Go 언어 제거하기${NC}"
sudo apt-get purge golang-go -y
sudo rm -rf /usr/local/go

echo -e "${CYAN}GOPATH 환경 변수가 설정된 경우 제거${NC}"
if [ -d "$GOPATH" ]; then
    sudo rm -rf "$GOPATH"
fi

echo -e "${CYAN}~/bashrc 또는 ~/.profile에서 go 관련된 항목 제거 (수동으로 파일 열어서 제거할 수 있음)${NC}"
sed -i '/export GOROOT=\/usr\/local\/go/d' ~/.bashrc
sed -i '/export PATH=\$PATH:\$GOROOT\/bin/d' ~/.bashrc
sed -i '/export GOPATH=\$HOME\/go/d' ~/.bashrc
sed -i '/export PATH=\$PATH:\$GOPATH\/bin/d' ~/.bashrc

echo -e "${CYAN}설정 파일 다시 적용${NC}"
source ~/.bashrc
source ~/.profile

echo -e "${CYAN}셀레스티아 서비스 멈추기${NC}"
sudo systemctl stop celestia-light
sudo systemctl disable celestia-light

echo -e "${CYAN}셀레스티아 서비스 지우기${NC}"
sudo rm /etc/systemd/system/celestia-light.service
sudo systemctl daemon-reload

echo -e "${CYAN}AUTH_TOKEN 삭제하기${NC}"
unset AUTH_TOKEN

echo -e "${CYAN}남아있는 스크린도 삭제할게요${NC}"
screen -X -S Celestia_wallet kill
screen -X -S Celestia_logs kill

echo -e "${BOLD}${RED}남아있던 셀레스티아 노드가 흔적도 없이 지워졌어요. 나중에 재설치 하고 싶으면 다시 스크립트 입력해서 하세용~ ㅎㅎ${NC}"
}
# 메인 메뉴
echo && echo -e "${BOLD}${MAGENTA}celestia light 노드 자동 설치 스크립트${NC} by 코인러브미순
${CYAN}원하는 거 고르시고 실행하시고 그러세효. ${NC}
 ———————————————————————
 ${GREEN} 1. 기본파일 설치 및 celestia_light 설치 ${NC}
 ${GREEN} 2. celestia_light 실행 ${NC}
 ${GREEN} 3. AUTH_TOKEN 설정(2번 진행한 뒤에 꼭 해줘) ${NC}
 ${GREEN} 4. celestia_light 업데이트(V0.17.2) ${NC}
 ${GREEN} 5. celestia_light 스테이터스 확인 ${NC}
 ${GREEN} 6. celestia 재시작 ${NC}
 ${GREEN} 7. celestia 삭제 ${NC}
 ———————————————————————" && echo

# 사용자 입력 대기
echo -ne "${BOLD}${MAGENTA}어떤 작업을 수행하고 싶으신가요? 위 항목을 참고해 숫자를 입력해 주세요: ${NC}"
read -e num

case "$num" in
1)
    celestia_installation
    ;;
2)
    celestia_execution
    ;;
3)
    AUTH_TOKEN
    ;;
4)
    celestia_update
    ;;
5)
    check_status_of_celestia
    ;;
6)
    restart_celestia
    ;;
7)
    uninstall_celestia
    ;;
*)
    echo -e "${BOLD}${RED}숫자 못 읽음? 진짜 병신이니 눈깔 삐엇니? 죽어 그냥 자살해 시발 1~5 하나 제대로 입력 못하는 주제에 무슨 노드를 쳐 돌리고~ 에드작을 한다 그러고~ 시발 서당개도 3년이면 풍월을 읊는다는데 만물의 영장이라는 게 시발 에드작을 반년 가까이 하고도 시발 숫자 하나 입력하는 법을 모르고 개 씨발 병신 좆버러지 같은 년 에휴 왜 사니? 여긴 왜 들어왔니? 코인이 하고 싶긴 하니? 너 평소에 하라는 에드작은 다 열심히 하고 있니? 안일하게 살지마 세상에 돈 벌기 쉬운 게 어딨어 다들 피땀흘려서 열심히 돈 버는데 지는 이거 하기 싫다고 편하게 딸깍이나 하러 와서는 숫자 하나 제대로 입력 못하고 내 복창이 터진다 씨발 에휴 병신 금수련아 짐승련아 대체 왜 그러고 사니 존재 자체가 인류의 공해야 너는 그냥 에휴 긴말 안 할게 죽어라 걍 에휴 ㅄ;;;;;;;;${NC}"
    ;;
esac