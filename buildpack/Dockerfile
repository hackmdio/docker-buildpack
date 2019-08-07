FROM node:8.16.0-jessie

ENV DEBIAN_VERSION_NAME jessie

RUN set -x && \
        apt-get update && \
        # install postgres client
        apt-get install -y --no-install-recommends apt-transport-https && \
        echo "deb http://apt.postgresql.org/pub/repos/apt/ ${DEBIAN_VERSION_NAME}-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
        apt-get update && \
        apt-get install -y --no-install-recommends postgresql-client-9.6 && \
        rm -rf /var/lib/apt/lists/* && \
        # upgrade npm to 6.10
        npm i -g npm@6.10.3 && \
        # install node-prune
        npm i -g node-prune && npm cache clean --force && \
        # setup github ssh key
        mkdir -p /root/.ssh && \
        ssh-keyscan -H github.com >> /root/.ssh/known_hosts && \
        # setup git credential helper
        mkdir -p /root/git && \
        git config --global credential.helper 'store --file /root/git/credentials'

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["node"]
