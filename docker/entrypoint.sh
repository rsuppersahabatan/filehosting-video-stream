#!/bin/sh
set -e

# Ensure required directories exist (volume mounts may create empty dirs)
mkdir -p \
  /var/www/storage/framework/cache/data \
  /var/www/storage/framework/sessions \
  /var/www/storage/framework/views \
  /var/www/storage/framework/testing \
  /var/www/storage/logs \
  /var/www/storage/app/public \
  /var/www/bootstrap/cache

# Fix ownership/perms on bind-mounted writable dirs.
# Ignore failures (e.g. Windows bind mounts where chown is a no-op).
chown -R laravel:laravel /var/www/storage /var/www/bootstrap/cache 2>/dev/null || true
chmod -R ug+rwX /var/www/storage /var/www/bootstrap/cache 2>/dev/null || true

# Run php-fpm as root so it can bind/open log streams; the pool config
# spawns workers as the unprivileged "laravel" user. For other commands
# (composer, artisan, etc.) drop to the laravel user via gosu.
if [ "$1" = "php-fpm" ]; then
  exec "$@"
fi

exec gosu laravel "$@"
