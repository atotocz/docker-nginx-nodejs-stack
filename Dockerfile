FROM node:7.8.0

ENV NODE_ENV=production \
    DEBIAN_FRONTEND=noninteractive \
    NODE_PORT=3000 \
    YARN_VERSION=0.20.3

RUN apt-get -qqy update && \
    apt-get install -qqy nginx supervisor libelf1 vim && \
    apt-get clean && \
    curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" && \
    mv yarn.js /usr/local/bin/yarn && \
    chmod +x /usr/local/bin/yarn && \
    yarn --version && \
    yarn global add pm2@lates && \
    curl -sL https://getsentry.com/get-cli/ | bash && \
    rm -rf /var/www/html/*

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 80
EXPOSE 8080

COPY rootfs /
