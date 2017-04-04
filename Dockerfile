FROM node:7.8.0

ENV NODE_ENV=production \
	DEBIAN_FRONTEND=noninteractive \
	NODE_PORT=3000

RUN apt-get -qqy update && \
	apt-get install -qqy nginx supervisor libelf1 vim && \
	apt-get clean && \
	npm --loglevel=silent install -g yarn@0.20.3 pm2@latest && \
	curl -sL https://getsentry.com/get-cli/ | bash && \
	rm -rf /var/www/html/*

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 80
EXPOSE 8080

COPY rootfs /
