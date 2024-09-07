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

## 추가로 해야하는 작업

디코 링크 달아줄 거니까 기달.

## 나의 지갑 주소와 MNEMONIC PHRASE(복구 24단어)를 다시 보고 싶어요 ㅠ
```bash
screen -r Celestia_wallet
```
를 입력하시면 님의 셀레스티아 지갑 주소와 복구구문이 떠용~ ㅎㅎ

