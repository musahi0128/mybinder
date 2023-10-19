#!/bin/bash
touch $XAUTHORITY
pip install yt-dlp udocker > /dev/null 2>&1
udocker install > /dev/null 2>&1
git lfs install > /dev/null 2>&1
ssh-keyscan -H hf.co >> /home/ubuntu/.ssh/known_hosts 2> /dev/null
chmod -R 600 /home/ubuntu/.ssh/*
mkdir /tmp/git && cd /tmp/git
git clone git@hf.co:datasets/idnfs/ubuntu > /dev/null 2>&1
cd /tmp/git/ubuntu
git config user.email "idn-freestream@ccmail.uk"
git config user.name "idnfs"
rclone move . /home/ubuntu/ > /dev/null 2>&1
rm -rf /tmp/git
cd /home/ubuntu
git clone git@hf.co:spaces/idnfs/xfce4 > /dev/null 2>&1
cd /home/ubuntu/xfce4
git config user.email "idn-freestream@ccmail.uk"
git config user.name "idnfs"
cd /home/ubuntu
tmux new-session -n 'sshd' -d && tmux send-keys -t 0 'while true; do /usr/sbin/sshd -d; done' Enter && \
tmux new-window -d -n 'healthcheck.io' && tmux send-keys -t 1 'while true; do echo $(date) - sending alive signal to Healtchecks.io; curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/756fdfa4-72b8-431b-83c4-ba006a4e4d4b; sleep 300; done' Enter && \
tmux new-window -d -n 'srv.us' && tmux send-keys -t 2 'while true; do ssh -o "StrictHostKeyChecking no" -o "BatchMode yes" srv.us -R 1:localhost:2022 -R 2:localhost:7681 -R 3:localhost:5901 -R 4:localhost:6080 -R 5:localhost:8185; done' Enter && \
tmux new-window -d -n 'ttyd' && tmux send-keys -t 3 'while true; do ttyd -p 7681 -t fontSize=13 -t fontFamily=monospace -t titleFixed="ttyd :: hf.co/idnfs/xfce4" -W -b /$secret_path tmux a; sleep 3; done' Enter && \
tmux new-window -d -n 'vncserver' && tmux send-keys -t 4 'while true; do vncserver :1 -fg -verbose -localhost=1 -desktop "hf.co/idnfs/xfce4" -rfbport 5901 -SecurityTypes None -auth /home/ubuntu/.Xauthority -geometry 1920x960 -depth 24; done' Enter && \
tmux new-window -d -n 'noVNC' && tmux send-keys -t 5 'while true; do websockify --web=/usr/share/novnc/ 6080 localhost:5901; done' Enter && \
tmux new-window -d -n 'firefox' && tmux send-keys -t 6 'while true; do firefox -no-remote -headless -P keep-alive; sleep 5; done' Enter && \
tmux new-window -d -n 'TelDrive' && tmux send-keys -t 7 'cd /home/ubuntu/.teldrive; while true; do ./teldrive; sleep 3; done' Enter && \
tmux new-window -d -n 'webdav' && tmux send-keys -t 8 'while true; do rclone serve webdav /home/ubuntu --addr :7860 --exclude ".*" --exclude ".*/" --exclude="cookies.txt" --exclude xfce4/ --dir-cache-time 2s --poll-interval 1s --vfs-cache-mode full --no-modtime --read-only -vvv 2>&1 | tee /tmp/rclone-webdav.log; sleep 3; done' Enter && \
tmux new-window
tail -n +1 --pid=$(tmux display-message -pF '#{pid}') -f /tmp/rclone-webdav.log
