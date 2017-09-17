#!/usr/bin/env bash

set -ex

export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

cd /shared
sudo chown -R ubuntu:ubuntu .

cat wp-tests-config-sample.php \
| sed -e s/youremptytestdbnamehere/wordpress_tests/ \
| sed -e s/yourusernamehere/root/ \
| sed -e s/yourpasswordhere/1111/ > wp-tests-config.php

cd /shared/tests/phpunit/data/plugins/
svn co \
    https://plugins.svn.wordpress.org/wordpress-importer/trunk/ \
    wordpress-importer

cd /shared
phpunit
