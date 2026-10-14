#!/bin/bash
# Installs Hugo (extended edition) in the CI image.
set -eux

HUGO_VERSION="0.167.0"

curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" | tar -xz -C /usr/local/bin hugo
hugo version
