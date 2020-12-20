FROM alpine:3.12

WORKDIR /app

RUN apk add curl nginx supervisor bash gettext \
  && curl https://i.jpillora.com/chisel! | bash

COPY start.sh /usr/local/bin/start.sh
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx_site.template /etc/nginx/conf.d/default.template
COPY index.html /app/www/index.html

ENV AUTH=
ENV CHISEL_KEY=

RUN mkdir -p /app/logs/ \
  && mkdir -p /app/logs/nginx/ \
  && chmod -R 776 /app/logs/ \
  && mkdir -p /var/lib/nginx/ \
  && chmod -R 776 /var/lib/nginx/

CMD ["/usr/local/bin/start.sh"]

