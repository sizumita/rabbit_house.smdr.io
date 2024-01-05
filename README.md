# rabbit_house.smdr.io

いらっしゃいませ、ラビットハウスへようこそ！

## setup

- ansible/files/certificate/rsa_key.privを作る
- bash create-certs.sh

- scpか何かで、Star_CUPS_Driver-3.14.0_linux.tarをdriverディレクトリにコピー
- bash install_driver.sh
- secrets/OPENAI_API_KEY.txtを作る

## VPN設定のダウンロード

証明書作る

```bash
bash create-client.sh OOO@smdr.io
```

それを落とす

```bash
scp root@rabbit-house.smdr.io:~/rabbit_house.smdr.io/Client-OOO@smdr.io.p12 ./
```

証明書の信頼を忘れずに！
