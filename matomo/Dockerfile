ARG MATOMO_VERSION
FROM matomo:$MATOMO_VERSION


# Install envsubst
RUN curl -L "https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-$(uname -s)-$(uname -m)" -o envsubst && \
  chmod +x envsubst && \
  mv envsubst /usr/local/bin

WORKDIR /var/www/html

COPY config.ini.tmpl.php config/
COPY cf-entrypoint.sh /cf-entrypoint.sh


ENTRYPOINT ["/cf-entrypoint.sh"]
CMD ["apache2-foreground"]