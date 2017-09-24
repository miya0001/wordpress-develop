#!/usr/bin/env bash

set -ex

export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

sudo chown -R ubuntu:ubuntu .

cat wp-tests-config-sample.php \
| sed -e s/youremptytestdbnamehere/wordpress_tests/ \
| sed -e s/yourusernamehere/root/ \
| sed -e s/yourpasswordhere/1111/ > wp-tests-config.php

svn co \
    https://plugins.svn.wordpress.org/wordpress-importer/trunk/ \
    tests/phpunit/data/plugins/wordpress-importer

phpunit
