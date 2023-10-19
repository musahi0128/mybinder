FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Jakarta
ENV TERM xterm
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

COPY setup.sh /setup.sh
RUN /bin/bash /setup.sh > /dev/null 2>&1 && rm /setup.sh
COPY id_binder $HOME/.ssh/id_rsa
COPY id_binder.pub $HOME/.ssh/authorized_keys
RUN chmod 0600 $HOME/.ssh/* && chown 1000:1000 $HOME && chown -R 1000:1000 $HOME
COPY entrypoint.sh /entrypoint.sh
RUN chown 1000:1000 /entrypoint.sh

WORKDIR ${HOME}
USER ${USER}
