#!/usr/bin/env bash
set -e

replace-vars.sh /opt/traccar-server/config-templates/traccar.xml \
    > /opt/traccar-server/conf/traccar.xml
if [[ -z "$OIDC_ISSUER_URL" ]]; then
    echo "\"OIDC_ISSUER_URL\" is not set. Removing OIDC configuration."
    sed --in-place "/<entry key=\"openid.[a-zA-Z]*\">.*<\/entry>/d" \
        /opt/traccar-server/conf/traccar.xml
fi
if [[ -z "$FILTER_ACCURACY" ]] && [[ -z "$FILTER_SKIP_LIMIT" ]]; then
    echo "No filter is set. Removing filter.enable configuration."
    sed --in-place "/<entry key=\"filter.enable\">.*<\/entry>/d" \
        /opt/traccar-server/conf/traccar.xml
fi
if [[ -z "$FILTER_ACCURACY" ]]; then
    echo "\"FILTER_ACCURACY\" is not set. Removing its configuration."
    sed --in-place "/<entry key=\"filter.accuracy\">.*<\/entry>/d" \
        /opt/traccar-server/conf/traccar.xml
fi
if [[ -z "$FILTER_SKIP_LIMIT" ]]; then
    echo "\"FILTER_ACCURACY\" is not set. Removing its configuration."
    sed --in-place "/<entry key=\"filter.skipLimit\">.*<\/entry>/d" \
        /opt/traccar-server/conf/traccar.xml
fi

exec "$@"
