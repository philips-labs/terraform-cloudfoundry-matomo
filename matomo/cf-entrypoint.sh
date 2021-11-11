#!/usr/bin/env sh
set -e

echo "$@"
envsubst < /var/www/html/config/config.ini.tmpl.php > /var/www/html/config/config.ini.php

chown www-data:www-data /var/www/html/config/config.ini.php

/entrypoint.sh "$@"