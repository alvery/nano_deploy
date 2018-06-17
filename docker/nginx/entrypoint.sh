#!/bin/sh

sed -i 's| API_DOMAIN| '"$API_DOMAIN"'|g' /etc/nginx/conf.d/default.conf

# Execute CMD
exec "$@"
