# 셀레스티아 설치하는 방법

- 먼저 콘타보에 로그인하세용~
## 설치 명령어
```bash
[ -f "celestia_light.sh" ] && rm celestia_light.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/celestia_light.sh && chmod +x celestia_light.sh && ./celestia_light.sh
```
위 문구를 복사해서 콘타보에 입력하며
![image](https://github.com/user-attachments/assets/727f61dd-2a36-4d32-950a-5dba42873024)
이런 화면이 뜰 거에요. 여기서 1번 입력하시면 됩니당.

1번 입력하고 설치가 되다가 중간에 어떤 명령어가 뜰 거에요. 그러면
```bash
screen -S Celestia_wallet
```
를 치시면 새로운 화면이 뜰 텐데,
```bash
celestia light init --core.ip rpc.celestia.pops.one --p2p.network celestia
```
를 치면 님의 지갑 주소와 MNEMONIC PHRASE(복구구문)이 떠용. 이거 어디다 잘 저장해 두세욤 ㅎㅎ

그러고

> ### CTRL + A + D를 눌러서 밖으로 나오기!

그 다음으로는
```bash
[ -f "celestia_light.sh" ] && rm celestia_light.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/celestia_light.sh && chmod +x celestia_light.sh && ./celestia_light.sh
```
를 다시 입력해서 '2'를 입력하신 뒤에 실행까지 완료해 주세요~

## AUTH_TOKEN 설정하기
```bash
[ -f "celestia_light.sh" ] && rm celestia_light.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/celestia_light.sh && chmod +x celestia_light.sh && ./celestia_light.sh
```
를 다시 입력해서 3번을 입력하시면 됩니다~

그러다 보면
```bash
{"id":0,"jsonrpc":"2.0","result":{"ID":"12D3KooWRPi7xNb4DVVReLXBazkEyPi4oDMpdKbsexMxo4NcuAED","Addrs":["/ip4/111.11.111.111/tcp/2121","/ip4/123.456.789.123/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/123.345.322.111/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/11.11.111.111/udp/2121/quic-v1","/ip4/100.42.177.209/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q","/ip4/111.111.111.111/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q","/ip4/127.0.0.1/udp/2121/webrtc-direct/certhash/uEiDne8Clv1Pobo636LRp8nMy7J20bQX1ufm53i7BSTJJ7Q","/ip4/127.0.0.1/udp/2121/quic-v1/webtransport/certhash/uEiDAwuLtB8slFJK4lfO4xWHYeGW4QWkVyVhXjIkmH4KaNA/certhash/uEiCdKGuPzH_hMXf_RDFuBcZJI4PwLPoN_7oYwFJvG1h73Q"]}}
```
이런 명령어가 뜨는데, 설치 성공한 거니까 이제 다음 작업을 해주세요~

> ## 그 외에도....
```bash
[ -f "celestia_light.sh" ] && rm celestia_light.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/celestia_light.sh && chmod +x celestia_light.sh && ./celestia_light.sh
```
![image](https://github.com/user-attachments/assets/be6cf918-66e3-4ca2-ae1a-3ad536b338fc)
4번, 5번, 6번 입력하시면 각각 업데이트, 상태창 확인, 재시작 등등 다 가능하니까 많이 애용해 주세요~

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

## 다른 방법으로 내 셀레스티아가 잘 굴러가는지 보고 싶어요 (+지갑 확인)

```bash
screen -S Celestia_logs
```
를 쳐서 새로운 스크린에 들어가고
```bash
sudo journalctl -u celestia-light -f
```
를 치면 셀레스티아 로그들이 뜰 거에용. 
![image](https://github.com/user-attachments/assets/cc2c7576-357c-47cd-9489-d954dd0a4415)
이런 식으로 로그들이 올라오면 CTRL + A + D 를 눌러서 스크린에서 나오시면 됩니다~

로그들을 다시 보고 싶으면
```bash
screen -r Celestia_logs
```
를 치면 됩니당

> 만약 내 노드에 있는 셀레스티아 지갑을 보고 싶으시다면?
```bash
cd ~/celestia-node && ./cel-key list --node.type light --keyring-backend test --p2p.network celestia
```
를 입력하면 내 지갑이 보여요~

## 내가 셀레스티아 노드를 내 가상서버에서 지워버리고 싶어요 ㅠㅠ
```bash
[ -f "celestia_light.sh" ] && rm celestia_light.sh; wget -q https://raw.githubusercontent.com/byonjuk/Celestia_light/main/celestia_light.sh && chmod +x celestia_light.sh && ./celestia_light.sh
```
를 입력해서 '7'을 입력하면 셀레스티아가 말끔하게 지워져요~

## 좆됐어요. 저 셀레스티아 이전 지갑으로 다시 깔아야 돼요(이전 키 복구하고 싶어요)
> #### ***절대 권장하지 않음***

1. 터미널을 킨다***콘타보로그인은하지마세요제발***

2. 아래 명령어를 입력한다
```bash
mkdir -p /likalika/yourcelestiakeys
```

3. 아래 명령어를 입력한다
```bash
scp -r root@you.r.IP.address:~/.celestia-light/keys /likalika/yourcelestiakeys
```

3-1. 이거 입력하면 비번 입력하란 문구가 뜨는데 비번 입력한다. 비번 입력하고 나면 100% 되면서 끝날 거임

4. 이제 셀레스티아가 깔린 콘타보를 초기화한다. (다른 거 백업할 거 있으면 백업해 두셈)

5. 터미널 다시 키고 ***내 콘타보로 로그인***해서 깃헙 들어가서 쉘스크립트 명령어 치고 1번을 입력해서 기본 설치를 마친다. (celestia init까지 하고 오셈)

6. 아래 키를 입력한다.
```bash
cd && sudo rm -rf ~/.celestia-light/keys/*
```

7. 다시 터미널을 킨다***콘타보로그인은하지마세요제발***

8. 아래 명령어를 입력한다
```bash
scp -r /likalika/yourcelestiakeys/keys/* root@you.r.IP.address:~/.celestia-light/keys
```

8-1. 또 비번 입력하라는데 입력하고 100% 되면 냅둔다.

9. 터미널 또 새로 켜서 ***내 콘타보로 로그인***한다.

10. 아래 명령어 입력해서 로컬에 저장된 파일이랑 콘타보에 저장된 파일이랑 매치되는지 확인한다. 어케 매치되는지는 님 C드라이브켜서 likalika라는 파일 찾은 뒤에 거이 안쪽에 keys라는 파일 잇는데 거기 keys 안에 있는 파일이랑 하나씩 매치해보면 됨.
```bash
ls -l ~/.celestia-light/keys
```

11. 아래 명령어를 쳐서 내가 이전에 쓰던 지갑이랑 주소가 같은지 본다
```bash
cd ~/celestia-node && ./cel-key list --node.type light --keyring-backend test --p2p.network celestia
```
12. 아래 두 명령어를 복사한다.
```bash
chmod 600 ~/.celestia-light/keys/*
chmod 700 ~/.celestia-light/keys/keyring-test
```

13. 이제 다시 스크립트 켜서 2번, 3번 과정 하면 됨

14. 새로 터미널을 킨다***콘타보로그인은하지마세요제발***

15. 아래 명령어를 입력한다
```bash
rm /likalika/yourcelestiakeys
```
