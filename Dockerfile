FROM node:8.4.0

ENV NODE_ENV=production \
    DEBIAN_FRONTEND=noninteractive \
    NODE_PORT=3000 \
    PM2_VERSION=2.4.3 \
    YARN_VERSION=1.0.1

RUN apt-get -qqy update && \
    apt-get install -qqy nginx supervisor libelf1 vim && \
    apt-get clean && \
    curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" && \
    curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" && \
    gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz && \
    rm -rf /opt/yarn && \
    mkdir -p /opt/yarn && \
    tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 && \
    rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz && \
    yarn global add pm2@$PM2_VERSION sentry-cli-binary && \
    rm -rf /var/www/html/* && \
    echo "=== yarn version: ===" && \
    yarn --version && \
    echo "=== sentry-cli version: ===" && \
    sentry-cli --version

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 80
EXPOSE 8080

COPY rootfs /
