#!/usr/bin/env bash

set -x

# chrome, java
mkdir -p /usr/share/man/man1
apt-get update
apt install -y locales unzip gzip zip build-essential wget curl bzip2 gnupg xvfb libpq-dev \
        dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev openjdk-8-jdk
locale-gen en_US.UTF-8
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -y -f

# git
cd /usr/src
wget -O git.tar.gz https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz
tar xzf git.*
cd git-*
make prefix=/usr/local/git all
make prefix=/usr/local/git install
cd /usr/src
rm -rf git-* git.tar.gz

# jq
cd /home/jenkins
wget https://github.com/stedolan/jq/releases/download/jq-${JQ_RELEASE_VERSION}/jq-linux64
mv jq-linux64 jq
chmod +x jq
cp jq /usr/bin/jq
rm jq

# Docker
curl -f https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz | tar xvz
mv docker/docker /usr/bin/
rm -rf docker

# helm
curl -f https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz  | tar xzv
mv linux-amd64/helm /usr/bin/
mv linux-amd64/tiller /usr/bin/
rm -rf linux-amd64

curl -L https://get.helm.sh/helm-v3.0.0-alpha.1-linux-amd64.tar.gz | tar xzv
mv linux-amd64/helm /usr/bin/helm3
rm -rf linux-amd64

# helm 3
curl -f -L https://github.com/jstrachan/helm/releases/download/untagged-93375777c6644a452a64/helm-linux-amd64.tar.gz -o helm3.tgz
tar xf helm3.tgz
mv helm /usr/bin/helm3
rm *.tgz

# gcloud
curl -f -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz | tar xzv
mv google-cloud-sdk /usr/bin/
# install the docker credential plugin
gcloud components install docker-credential-gcr

# jx-release-version
RUN curl -f -o ./jx-release-version -L https://github.com/jenkins-x/jx-release-version/releases/download/v${JX_RELEASE_VERSION}/jx-release-version-linux && \
  mv jx-release-version /usr/bin/ && \
  chmod +x /usr/bin/jx-release-version

# exposecontroller
curl -f -L https://github.com/fabric8io/exposecontroller/releases/download/v$EXPOSECONTROLLER_VERSION/exposecontroller-linux-amd64 > exposecontroller
chmod +x exposecontroller
mv exposecontroller /usr/bin/

# skaffold
curl -f -Lo skaffold https://storage.googleapis.com/skaffold/releases/v${SKAFFOLD_VERSION}/skaffold-linux-amd64
chmod +x skaffold
mv skaffold /usr/bin

# container structure test
curl -LO https://storage.googleapis.com/container-structure-test/v${CONTAINER_STRUCTURE_TEST_VERSION}/container-structure-test-linux-amd64
chmod +x container-structure-test-linux-amd64
mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test

# updatebot
curl -f  -o ./updatebot -L https://oss.sonatype.org/content/groups/public/io/jenkins/updatebot/updatebot/${UPDATEBOT_VERSION}/updatebot-${UPDATEBOT_VERSION}.jar
chmod +x updatebot
cp updatebot /usr/bin/
rm -rf updatebot

# draft
curl -f https://azuredraft.blob.core.windows.net/draft/draft-canary-linux-amd64.tar.gz  | tar xzv
mv linux-amd64/draft /usr/bin/
rm -rf linux-amd64

# kubectl
curl -f -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/bin/

# aws ecr docker credential helper.
mkdir ecr
curl -f -L https://github.com/estahn/amazon-ecr-credential-helper/releases/download/v0.1.1/amazon-ecr-credential-helper_0.1.1_linux_amd64.tar.gz | tar -xzv -C ./ecr/
mv ecr/docker-credential-ecr-login /usr/bin/
rm -rf ecr

# ACR docker credential helper
mkdir acr
curl -f -L https://aadacr.blob.core.windows.net/acr-docker-credential-helper/docker-credential-acr-linux-amd64.tar.gz | tar -xzv -C ./acr/
mv acr/docker-credential-acr-linux /usr/bin/
rm -rf acr

# reflex
curl -f -L https://github.com/ccojocar/reflex/releases/download/v${REFLEX_VERSION}/reflex_${REFLEX_VERSION}_linux_amd64.tar.gz | tar xzv
mv reflex /usr/bin/

# goreleaser
mkdir goreleaser
curl -Lf https://github.com/goreleaser/goreleaser/releases/download/v${GORELEASER_VERSION}/goreleaser_Linux_x86_64.tar.gz | tar -xzv -C ./goreleaser/
mv goreleaser/goreleaser /usr/bin/
rm -rf goreleaser

# node js
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs
npm i -g watch-cli vsce typescript

# yarn
curl -f -L -o /tmp/yarn.tgz https://github.com/yarnpkg/yarn/releases/download/v${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz
tar xf /tmp/yarn.tgz
mv yarn-v${YARN_VERSION} /opt/yarn
ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn

# new jx
curl -f -L https://github.com/a60814billy/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz | tar xv && mv jx /usr/bin/

apt-get autoclean
apt-get clean
apt-get autoremove

rm -rf /var/lib/apt/lists/*
