#!/usr/bin/env bash
set -e -o pipefail

curl --fail --location http://localhost/ || exit 1
