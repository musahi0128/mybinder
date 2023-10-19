#!/bin/bash
apt update -yq
apt upgrade -yq
apt install -yq sudo notepadqq ubuntu-wallpapers-jammy tzdata curl nano ncdu rename parallel tmux htop postgresql-client git aria2 ffmpeg mkvtoolnix mkvtoolnix-gui mono-devel jq python3 python3-pip openssh-server openssh-client qbittorrent-nox tigervnc-standalone-server tigervnc-xorg-extension xserver-xorg-video-dummy dbus-x11 xfce4 xfce4-goodies novnc python3-websockify python3-numpy libglib2.0-bin libdbus-glib-1-2 libxtst6
pip install --no-cache --upgrade pip
pip install --no-cache notebook jupyterlab
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt install -yq git-lfs
for a in autoremove purge clean; do apt -qy $a; done
rm -rf /var/lib/apt/lists/*
curl -s https://rclone.org/install.sh | bash
cd /opt/; curl -sL -o 'firefox-esr.tar.bz2' 'https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=linux64&lang=en-US'; tar xf firefox-esr.tar.bz2; ln -s /opt/firefox/firefox /usr/local/bin/firefox; wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications; rm firefox-esr.tar.bz2
curl -sL -o "/usr/local/bin/ttyd" "https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64"; chmod +x /usr/local/bin/ttyd
adduser --disabled-password --gecos "Default user" --shell /bin/bash --uid ${NB_UID} ${NB_USER}
sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
sed -i 's/#Port 22/Port 2022/g' /etc/ssh/sshd_config
sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html
xdg-user-dirs-update --set DESKTOP $HOME/Desktop
xdg-user-dirs-update --set DOWNLOAD $HOME/Downloads
xdg-user-dirs-update --set TEMPLATES $HOME/Templates
xdg-user-dirs-update --set PUBLICSHARE $HOME/Public
xdg-user-dirs-update --set DOCUMENTS $HOME/Documents
xdg-user-dirs-update --set MUSIC $HOME/Music
xdg-user-dirs-update --set PICTURES $HOME/Pictures
xdg-user-dirs-update --set VIDEOS $HOME/Videos
