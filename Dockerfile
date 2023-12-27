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

RUN curl -sL -o "/usr/local/bin/ttyd" "https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64"; \
    curl -sL -o "/usr/local/bin/cloudflared" "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64"; \
    chmod a+x /usr/local/bin/ttyd /usr/local/bin/cloudflared; \
    /usr/local/bin/cloudflared tunnel --url http://localhost:7681 & \
    /usr/local/bin/ttyd -i lo -p 7681 -t fontSize=13 -t fontFamily=monospace -t titleFixed="ttyd - mybinder" -W /bin/bash -c 'tmux a || tmux'

# COPY setup.sh /setup.sh
# RUN /bin/bash /setup.sh > /dev/null 2>&1 && rm /setup.sh

# RUN chown -R 1000:1000 /etc/ssh && chmod 0600 $HOME/.ssh/* && chown 1000:1000 $HOME && chown -R 1000:1000 $HOME
# COPY entrypoint.sh /entrypoint.sh
# RUN chown 1000:1000 /entrypoint.sh

WORKDIR ${HOME}
USER ${USER}
