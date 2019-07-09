FROM debian:9

WORKDIR /home/jenkins

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PATH=/usr/local/git/bin:$PATH::/usr/bin/google-cloud-sdk/bin:/opt/google/chrome \
    GIT_VERSION=2.22.0 \
    JQ_RELEASE_VERSION=1.5 \
    DOCKER_VERSION=17.12.0 \
    EXPOSECONTROLLER_VERSION=2.3.34 \
    GCLOUD_VERSION=249.0.0 \
    HELM_VERSION=2.14.1 \
    JX_RELEASE_VERSION=1.0.17 \
    SKAFFOLD_VERSION=0.31.0 \
    CONTAINER_STRUCTURE_TEST_VERSION=1.8.0 \
    UPDATEBOT_VERSION=1.1.41 \
    REFLEX_VERSION=0.3.1 \
    GORELEASER_VERSION=0.110.0 \
    YARN_VERSION=1.3.2 \
    JX_VERSION=2.0.1354

ADD install.sh .
RUN chmod +x install.sh && ./install.sh && rm install.sh

CMD ["helm","version"]

