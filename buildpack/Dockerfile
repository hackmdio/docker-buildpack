FROM node:8.16.0-jessie

ENV DEBIAN_VERSION_NAME jessie

RUN apt-get update && \
        apt-get install -y --no-install-recommends apt-transport-https && rm -rf /var/lib/apt/lists/* && \
        echo "deb http://apt.postgresql.org/pub/repos/apt/ ${DEBIAN_VERSION_NAME}-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
        apt-get update && \
        apt-get install -y --no-install-recommends postgresql-client-9.6 && \
        npm i -g node-prune && \
        mkdir -p /root/.ssh && \
        ssh-keyscan -H github.com >> ~/.ssh/known_hosts && \
        mkdir -p /root/git && \
        git config --global credential.helper 'store --file /root/git/credentials'

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["node"]
