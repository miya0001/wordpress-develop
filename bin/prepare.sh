#!/usr/bin/env bash

set -ex

echo "PHP Version: ${PHP_VERSION}"

docker pull miya0001/phpenv:$PHP_VERSION
docker run -idt --name phpenv --privileged --volume="$(pwd)":/shared/:rw miya0001/phpenv:$PHP_VERSION "/bin/bash"

# Init MySQL
docker exec phpenv sudo chown -R mysql:mysql /var/lib/mysql
docker exec phpenv sudo mysql_install_db --datadir=/var/lib/mysql --user=mysql
docker exec phpenv sudo service mysql start

# Creates MySQL database for WordPress
docker exec phpenv mysql -u root -e "CREATE DATABASE wordpress_tests;" -p1111
