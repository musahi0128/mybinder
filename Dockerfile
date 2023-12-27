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

RUN curl -sL -o "/usr/local/bin/tty-share" "https://github.com/elisescu/tty-share/releases/download/v2.4.0/tty-share_linux-amd64"; \
    chmod a+x /usr/local/bin/tty-share; /bin/bash -c '/usr/local/bin/tty-share --public'

# COPY setup.sh /setup.sh
# RUN /bin/bash /setup.sh > /dev/null 2>&1 && rm /setup.sh

# RUN chown -R 1000:1000 /etc/ssh && chmod 0600 $HOME/.ssh/* && chown 1000:1000 $HOME && chown -R 1000:1000 $HOME
# COPY entrypoint.sh /entrypoint.sh
# RUN chown 1000:1000 /entrypoint.sh

WORKDIR ${HOME}
USER ${USER}
