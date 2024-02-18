#!/usr/bin/env bash
set -e

replace-vars.sh /opt/traccar-server/config-templates/traccar.xml \
    > /opt/traccar-server/conf/traccar.xml

exec "$@"
