FROM node:14.17.2-buster

ENV DEBIAN_VERSION_NAME=jessie NODE_ENV=production

ARG USER_NAME=hackmd
ARG UID=1500
ARG GID=1500

ADD common/fonts/*.otf /usr/share/fonts/opentype/noto/
ADD common/fonts/*.ttf /usr/share/fonts/truetype/noto/
# add font conf for fonts orders
ADD common/local.conf /etc/fonts/

RUN set -xe && \
        apt-get update && \
        # install postgres client
        apt-get install -y --no-install-recommends apt-transport-https && \
        echo "deb http://apt.postgresql.org/pub/repos/apt/ ${DEBIAN_VERSION_NAME}-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
        wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
        apt-get update && \
        apt-get install -y --no-install-recommends postgresql-client-11 && \
        rm -rf /var/lib/apt/lists/* && \
        # install pchecker
        wget https://github.com/hackmdio/portchecker/releases/download/v1.1.0/portchecker-linux-amd64.tar.gz && \
        tar xvf portchecker-linux-amd64.tar.gz -C /usr/local/bin && \
        mv /usr/local/bin/portchecker-linux-amd64 /usr/local/bin/pcheck && \
        rm portchecker-linux-amd64.tar.gz && \
        # Add user and groupd
        groupadd --gid $GID $USER_NAME && \
        useradd --uid $UID --gid $USER_NAME --no-log-init --create-home $USER_NAME && \
        mkdir /home/$USER_NAME/.npm && \
        echo "prefix=/home/$USER_NAME/.npm/" > /home/$USER_NAME/.npmrc && \
        # setup app dir
        mkdir -p /home/$USER_NAME/app && \
        # adjust permission
        chown -R $USER_NAME:$USER_NAME /home/$USER_NAME && \
        fc-cache -f -v && \
        dpkg-reconfigure fontconfig-config && \
        dpkg-reconfigure fontconfig

USER hackmd
ENV PATH="/home/hackmd/.npm/bin:$PATH"
WORKDIR /home/$USER_NAME/app
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["node"]

