#!/bin/sh

function createSymbolicLinks() {
	for i in vendor/bin/*; do
	  linkPath="/usr/local/bin/$(basename "$i")";
	  [ ! -r "$linkPath" ] && ln -s "$i" "$linkPath";
	done;
}

# Enable xdebug module, update xdebug ini config
if ! [ -z $XDEBUG ]; then
	docker-php-ext-enable xdebug
	[ -z "$HOST_NAME" ] && export HOST_NAME=$(ip r | grep default | awk '{ print $3 }');
	echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
	echo "xdebug.remote_host=$HOST_NAME" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

# Create symbolic links
createSymbolicLinks;

# Make storage and cache directories writable
chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache

chmod +x ./bin/init.sh

# Execute CMD
exec "$@"
