## 셀레스티아 설치하는 방법

- 먼저 콘타보에 로그인하세용~

```bash
[ -f "Celestia_installation.sh" ] && rm Celestia_installation.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/Celestia_installation.sh && chmod +x Celestia_installation.sh && ./Celestia_installation.sh
```

위에 문구 복사해서 설치를 완료하신 다음에

```bash
[ -f "Celestia_Execution.sh" ] && rm Celestia_Execution.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/Celestia_Execution.sh && chmod +x Celestia_Execution.sh && ./Celestia_Execution.sh
```

아래 명령어를 사용해서 설치 완료하시면 됩니다~

## AUTH_TOKEN 설정하기
```bahs
AUTH_TOKEN=$(celestia light auth admin --p2p.network celestia)
```
먼저 입력한 뒤에 
```bash
curl -X POST \
     -H "Authorization: Bearer $AUTH_TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
     http://localhost:26658
```
입력하기

```bash
{"id":0,"jsonrpc":"2.0","result":{"ID":"12D3KooWRPi7xNb4DVVReLXBazkEyPi4oDMpdKbsexMxo4NcuAED","Addrs":["/ip4/100.42.177.209/tcp/2121","/ip4/100.42.177.209/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/100.42.177.209/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/100.42.177.209/udp/2121/quic-v1","/ip4/100.42.177.209/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q","/ip4/100.42.177.209/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q","/ip4/127.0.0.1/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/127.0.0.1/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q"]}}
```
이런 명령어가 뜨면 성공!

## 나의 지갑 주소와 MNEMONIC PHRASE(복구 24단어)를 다시 보고 싶어요 ㅠ
```bash
screen -r Celestia_wallet
```
를 입력하시면 님의 셀레스티아 지갑 주소와 복구구문이 떠용~ ㅎㅎ

## 내가 go를 삭제하고 싶어요(go가 뭔지 모르면 스킵하셈)

```bash
# go언어 제거 하기
sudo apt-get purge golang*
sudo rm -rf /usr/local/go
sudo rm -rf $(echo $GOPATH)

# ~/bashrc 또는 ~/.profile에서 go 관련된 항목 제거(기존에 설정한 파일에서 작업)
source ~/.profile
source ~/.bashrc

# 제거 확인
go version

#설치된 셀레스티아 노드 삭제
cd ~/celestia-node
make clean
cd $HOME
sudo rm -rf ~/celesti-node
```
실행하셈.
