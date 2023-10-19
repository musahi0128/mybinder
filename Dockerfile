FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Jakarta
ENV TERM xterm

RUN apt -yq update && \
    apt -yq upgrade && \
    apt -yq install apt sudo tzdata curl nano ncdu rename parallel tmux htop postgresql-client git aria2 jq python3 python3-pip ssh && \
    curl -sLO "https://github.com/owenthereal/upterm/releases/download/v0.13.0/upterm_linux_amd64.tar.gz" && \
    tar xf upterm_linux_amd64.tar.gz && mv upterm /usr/local/bin/ && chmod +x /usr/local/bin/upterm && \
    sudo -H pip install --no-cache --upgrade pip && \
    sudo -H pip install --no-cache notebook jupyterlab calysto_bash

ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}
