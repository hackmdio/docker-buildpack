FROM node:24.11.0-bookworm

ENV DEBIAN_VERSION_NAME=bookworm

ARG USER_NAME=hackmd
ARG UID=1500
ARG GID=1500

RUN set -xe && \
        # upgrade system
        apt-get update && \
        apt-get upgrade -y && \
        # install postgres client
        apt-get install -y --no-install-recommends postgresql-client-15 && \
        rm -rf /var/lib/apt/lists/* && \
        # upgrade npm to v10
        npm -g install npm@10 && \
        # install node-prune
        npm i -g node-prune && npm cache clean --force && \
        # Add user and groupd
        groupadd --gid $GID $USER_NAME && \
        useradd --uid $UID --gid $USER_NAME --no-log-init --create-home $USER_NAME && \
        mkdir -p /home/$USER_NAME/.npm && \
        mkdir -p /home/$USER_NAME/.ssh && \
        mkdir -p /home/$USER_NAME/git && \
        mkdir -p /home/$USER_NAME/app && \
        echo "prefix=/home/$USER_NAME/.npm/" > /home/$USER_NAME/.npmrc && \
        git config --global credential.helper 'store --file /home/$USER_NAME/git/credentials' && \
        # adjust permissions
        chown -R $USER_NAME:$USER_NAME /home/$USER_NAME

USER hackmd
ENV PATH="/home/hackmd/.npm/bin:$PATH"
WORKDIR /home/$USER_NAME/app
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["node"]
