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

WORKDIR ${HOME}
USER ${USER}

COPY entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
