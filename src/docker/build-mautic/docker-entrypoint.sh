#!/bin/bash
set -e

echo "$GIT_ACCESS_TOKEN" > /git-password.txt
cd /var/www/html
gh auth login --with-token < /git-password.txt
gh repo clone $GIT_REPO /var/www/html/mautic/
cd /var/www/html/mautic
git checkout $GIT_BRANCH

composer self-update --1
composer global require hirak/prestissimo
composer update mautic/api-library
composer validate
composer install --prefer-dist --no-progress --no-suggest

php build/package_release.php -b=$MAUTIC_VERSION
