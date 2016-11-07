FROM node:6.9.1

ENV NODE_ENV=production \
	DEBIAN_FRONTEND=noninteractive \
	NODE_PORT=3000

RUN apt-get -qqy update && \
	apt-get install -qqy nginx supervisor libelf1 && \
	apt-get clean && \
	npm --loglevel=silent install -g yarn pm2@latest && \
	curl -sL https://getsentry.com/get-cli/ | bash && \
	rm -rf /var/www/html/*

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
EXPOSE 80

COPY rootfs /

