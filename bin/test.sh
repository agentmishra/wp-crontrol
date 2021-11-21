#!/usr/bin/env bash

# -e          Exit immediately if a pipeline returns a non-zero status
# -o pipefail Produce a failure return code if any command errors
set -eo pipefail

# Specify the directory where the WordPress installation lives:
WP_CORE_DIR="${PWD}/tests/wordpress"

# Shorthand:
WP="docker-compose run --rm cli --path=$WP_CORE_DIR --url=http://localhost"

# Reset or install the test database:
$WP db reset --yes

# Install WordPress:
$WP core install --title="Example" --admin_user="admin" --admin_password="admin" --admin_email="admin@example.com"

# Run the functional tests:
./vendor/bin/codecept run --steps "$1"
