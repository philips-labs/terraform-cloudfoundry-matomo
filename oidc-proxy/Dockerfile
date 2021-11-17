FROM nginx:1.20.1-alpine AS runtime

COPY ./matomo.template /etc/nginx/conf.d

EXPOSE 8080

CMD envsubst < /etc/nginx/conf.d/matomo.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'