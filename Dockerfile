FROM ghcr.io/musahi0128/ubuntu-docker:main

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Jakarta
ENV TERM xterm
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

COPY id_binder $HOME/.ssh/id_rsa
COPY id_binder.pub $HOME/.ssh/authorized_keys

RUN curl -sL -o "/usr/local/bin/ttyd" "https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64"; chmod +x /usr/local/bin/ttyd; \
    /usr/local/bin/ttyd -p 7681 -t fontSize=13 -t fontFamily=monospace -t titleFixed="ttyd - mybinder" -W /bin/bash -c 'tmux a || tmux' & \
    ssh srv.us -t -x -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -R 1:localhost:7681 > /tmp/srv.us.addr 2>&1 && \
    cat /tmp/srv.us.addr

# COPY setup.sh /setup.sh
# RUN /bin/bash /setup.sh > /dev/null 2>&1 && rm /setup.sh

# RUN chown -R 1000:1000 /etc/ssh && chmod 0600 $HOME/.ssh/* && chown 1000:1000 $HOME && chown -R 1000:1000 $HOME
# COPY entrypoint.sh /entrypoint.sh
# RUN chown 1000:1000 /entrypoint.sh

WORKDIR ${HOME}
USER ${USER}
