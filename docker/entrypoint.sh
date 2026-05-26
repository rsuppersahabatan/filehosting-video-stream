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

# Drop privileges and exec the main process as the laravel user
exec gosu laravel "$@"
