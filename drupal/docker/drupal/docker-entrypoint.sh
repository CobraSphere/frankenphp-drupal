#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- frankenphp run "$@"
fi

if [ "$1" = 'frankenphp' ] || [ "$1" = 'drupal' ] || [ "$1" = 'drush' ]; then

    # Install Drupal the first time frankenphp is started
    if [ ! -f composer.json ]; then
        echo "First time install"

        # Install into a temp directory
        composer create-project --no-interaction --no-progress "${DRUPAL_PROJECT}:${DRUPAL_VERSION}" tmp_install

        # Install Drush and move to ../drupal folder
        cd tmp_install/
        composer require --dev drush/drush --no-interaction --no-progress
        cp -Rp . ..
        cd -
        rm -Rf tmp_install/

        # Set permissions for Caddy webserver
        chown -R www-data:www-data web/sites web/modules web/themes
        # rm -rf /app/public
        ln -sf /opt/drupal/web /app/public
        sed -i'' 's/public/web/' /etc/Caddyfile
        cp ./web/sites/default/default.settings.php ./web/sites/default/settings.php

        # Carry out Drupal Install with database URL and account password 'admin'
        ./vendor/drush/drush/drush site-install \
            --db-url=${DATABASE_URL} \
            --account-pass=${DRUPAL_ADMIN_PASSWORD} \
            --no-interaction \
            --verbose
    fi
fi

exec docker-php-entrypoint "$@"