FROM node:16.20.2-buster

ENV DEBIAN_VERSION_NAME buster

ARG USER_NAME=hackmd
ARG UID=1500
ARG GID=1500

RUN set -xe && \
        apt-get update && \
        # install postgres client
        apt-get install -y --no-install-recommends apt-transport-https && \
        echo "deb http://apt.postgresql.org/pub/repos/apt/ ${DEBIAN_VERSION_NAME}-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
        apt-get update && \
        apt-get install -y --no-install-recommends postgresql-client-11 && \
        if [ $(dpkg --print-architecture) = "arm64" ];then apt-get install -y --no-install-recommends phantomjs; fi && \
        rm -rf /var/lib/apt/lists/* && \
        # install node-prune
        npm i -g node-prune && npm cache clean --force && \
        # Add user and groupd
        groupadd --gid $GID $USER_NAME && \
        useradd --uid $UID --gid $USER_NAME --no-log-init --create-home $USER_NAME && \
        mkdir /home/$USER_NAME/.npm && \
        echo "prefix=/home/$USER_NAME/.npm/" > /home/$USER_NAME/.npmrc && \
        # setup github ssh key
        mkdir -p /home/hackmd/.ssh && \
        # ssh-keyscan -H github.com >> /home/hackmd/.ssh/known_hosts && \
        # setup git credential helper
        mkdir -p /home/hackmd/git && \
        git config --global credential.helper 'store --file /home/$USER_NAME/git/credentials' && \
        # setup app dir
        mkdir -p /home/$USER_NAME/app && \
        # adjust permission
        chown -R $USER_NAME:$USER_NAME /home/$USER_NAME

USER hackmd
ENV PATH="/home/hackmd/.npm/bin:$PATH"
WORKDIR /home/$USER_NAME/app
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["node"]
