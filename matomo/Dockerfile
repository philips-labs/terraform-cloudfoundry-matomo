FROM matomo:4.5-apache


# Install envsubst
RUN curl -L "https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-$(uname -s)-$(uname -m)" -o envsubst && \
  chmod +x envsubst && \
  mv envsubst /usr/local/bin

WORKDIR /var/www/html

COPY config.ini.tmpl.php config/
COPY cf-entrypoint.sh /cf-entrypoint.sh

# Install the GeoIP database
RUN curl -L -o /tmp/dbip.mmdb.gz https://download.db-ip.com/free/dbip-city-lite-2021-10.mmdb.gz && \
gzip -d < /tmp/dbip.mmdb.gz > /var/www/html/misc/DBIP-City.mmdb


# # add required plugins to the right directory
# # /usr/src/matomo/plugins/
RUN curl -L -o /tmp/LoginOIDC.tar.gz https://github.com/dominik-th/matomo-plugin-LoginOIDC/archive/refs/tags/4.0.0.tar.gz  && \
mkdir -p /usr/src/matomo/plugins/LoginOIDC && \
tar -xf /tmp/LoginOIDC.tar.gz --strip-components=1 -C /usr/src/matomo/plugins/LoginOIDC

ENTRYPOINT ["/cf-entrypoint.sh"]
CMD ["apache2-foreground"]