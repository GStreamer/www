#!/bin/sh
# Install the Apache configuration files, which Hugo cannot rename itself.
# Usage: tools/post-build.sh [public]
set -e
public=${1:-public}
cp src/copy/dot-htaccess "$public/.htaccess"
mkdir -p "$public/api"
cp src/copy/api-htaccess "$public/api/.htaccess"
