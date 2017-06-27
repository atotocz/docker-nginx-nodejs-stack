FROM node:8.1.2

ENV NODE_ENV=production \
    DEBIAN_FRONTEND=noninteractive \
    NODE_PORT=3000 \
    PM2_VERSION=2.4.3

RUN apt-get -qqy update && \
    apt-get install -qqy nginx supervisor libelf1 vim && \
    apt-get clean && \
    yarn global add pm2@$PM2_VERSION sentry-cli-binary && \
    rm -rf /var/www/html/* && \
    yarn --version && \
    sentry-cli --version

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 80
EXPOSE 8080

COPY rootfs /
