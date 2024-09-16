# 셀레스티아 설치하는 방법

- 먼저 콘타보에 로그인하세용~
## 설치 명령어
```bash
[ -f "Celestia_light.sh" ] && rm Celestia_light.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/celestia_light.sh && chmod +x Celestia_light.sh && ./Celestia_light.sh
```

위에 문구 복사해서 설치를 완료하신 다음에

```bash
screen -S Celestia_wallet
```
를 치시면 새로운 화면이 뜰 거에용

이후에
```bash
celestia light init --core.ip rpc.celestia.pops.one --p2p.network celestia
```
를 치면 님의 지갑 주소와 MNEMONIC PHRASE(복구구문)이 떠용. 이거 어디다 잘 저장해 두세욤 ㅎㅎ

그러고

> ### CTRL + A + D를 눌러서 밖으로 나오기!

그 다음으로는
```bash
[ -f "Celestia_Execution.sh" ] && rm Celestia_Execution.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/Celestia_Execution.sh && chmod +x Celestia_Execution.sh && ./Celestia_Execution.sh
```
이 명령어까지 복사해 주세요. 그 다음에 밑에 있는 Auth_Token까지 설정해 주세요~

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
{"id":0,"jsonrpc":"2.0","result":{"ID":"12D3KooWRPi7xNb4DVVReLXBazkEyPi4oDMpdKbsexMxo4NcuAED","Addrs":["/ip4/111.11.111.111/tcp/2121","/ip4/123.456.789.123/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/123.345.322.111/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/11.11.111.111/udp/2121/quic-v1","/ip4/100.42.177.209/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q","/ip4/111.111.111.111/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q","/ip4/127.0.0.1/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/127.0.0.1/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q"]}}
```
이런 명령어가 뜨면 성공!

## 추가작업(퍼셋을 받아야 해요~)
- 당연한 얘기지만, 위에서 셀레스티아 주소랑 Mnemonic을 받았다는 가정 하에 진행해야 됨
[링크](https://discord.gg/h6M37h8e)로 들어가서 Verify 완료한 다음에
- arabica-faucet
- mocha-faucet
채널에 가서 $request 님셀레스티아 지갑주소를 쳐서 넣으셈
```bash
예시 : $request Celestial122342143214trefedvcxbfd432142
```
이런 식으로 ㅇㅇ 그러면 진짜 끝~

## 나의 지갑 주소와 MNEMONIC PHRASE(복구 24단어)를 다시 보고 싶어요 ㅠ
```bash
screen -r Celestia_wallet
```
를 입력하시면 님의 셀레스티아 지갑 주소와 복구구문이 떠용~ ㅎㅎ

근데 이게 시간이 넘 오래 되면 ㅎ 안 뜰 수도 있어욤. 그건 스크린이 시간이 지나면서 삭제된 건데. 얘 뭐.... 안타깝습니다..

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
