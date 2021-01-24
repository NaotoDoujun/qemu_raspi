# qemu_raspi
[Raspberry Pi Debian Image](https://raspi.debian.net/tested-images/) のPi2イメージをqemuのarmv7l virtで動作させるコンテナ。  

# .Net Core3.1インストール済ディスクイメージ
debian_raspi2にpiユーザ作成、.net Core3.1インストール済のディスクイメージ(debian_raspi2.img)はGoogle Driveからダウンロード。  
[Google Drive](https://drive.google.com/file/d/1BnXNydI4Cyr0amCXR1HUiAmRF9nGf8mr/view?usp=sharing)

# コンテナビルド＆起動
imgフォルダ内にディスクイメージ(debian_raspi2.img)を配置し、/homeにマウントされること。
```
docker build -t qemu_raspi .
docker run -d -p 2222:2222 -v img:/home qemu_raspi
```
SSHにて接続
```
ssh -p 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pi@localhost
```