FROM matomo:4.5-apache

RUN apt-get update && \
apt-get install --no-install-recommends -y supervisor cron && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Install envsubst
RUN curl -L "https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-$(uname -s)-$(uname -m)" -o envsubst && \
  chmod +x envsubst && \
  mv envsubst /usr/local/bin

# configure supervisord
COPY supervisord.conf /etc/
COPY supervisord_configs/ /supervisor/conf.d

# Setup crontab to perform the matomo archive
COPY matomo-archive /etc/cron.d/matomo-archive
RUN chmod 0644 /etc/cron.d/matomo-archive && \
crontab /etc/cron.d/matomo-archive

# Install the GeoIP database
RUN curl -L -o /tmp/dbip.mmdb.gz https://download.db-ip.com/free/dbip-city-lite-2023-08.mmdb.gz && \
mkdir -p /var/www/html/misc/ && \
gzip -d < /tmp/dbip.mmdb.gz > /var/www/html/misc/DBIP-City.mmdb

# # add required plugins to the right directory
# # /usr/src/matomo/plugins/
RUN curl -L -o /tmp/LoginOIDC.tar.gz https://github.com/dominik-th/matomo-plugin-LoginOIDC/archive/refs/tags/4.0.0.tar.gz  && \
mkdir -p /usr/src/matomo/plugins/LoginOIDC && \
tar -xf /tmp/LoginOIDC.tar.gz --strip-components=1 -C /usr/src/matomo/plugins/LoginOIDC

WORKDIR /var/www/html

COPY config.ini.tmpl.php config/
COPY cf-entrypoint.sh /cf-entrypoint.sh

CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
