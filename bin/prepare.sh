#!/usr/bin/env bash

set -ex

echo "PHP Version: ${PHP_VERSION}"

docker pull miya0001/phpenv:$PHP_VERSION
docker run -idt --name phpenv --privileged -w /$(basename $(pwd)) --volume="$(pwd)":/$(basename $(pwd)):rw miya0001/phpenv:$PHP_VERSION "/bin/bash"

# Init MySQL
docker exec phpenv sudo chown -R mysql:mysql /var/lib/mysql
docker exec phpenv sudo mysql_install_db --datadir=/var/lib/mysql --user=mysql
docker exec phpenv sudo service mysql start

docker exec phpenv ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock || echo "/tmp/mysql.sock already exists."

# Creates MySQL database for WordPress
docker exec phpenv mysql -u root -e "CREATE DATABASE wordpress_tests;" -p1111
