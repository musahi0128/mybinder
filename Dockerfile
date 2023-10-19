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
COPY --chown=1001:1001 --chmod=0600 id_binder $HOME/.ssh/id_rsa
COPY --chown=1001:1001 --chmod=0600 id_binder.pub $HOME/.ssh/authorized_keys

WORKDIR ${HOME}
USER ${USER}

COPY entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
