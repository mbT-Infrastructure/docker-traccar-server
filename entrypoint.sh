#!/usr/bin/env bash
set -e

replace-vars.sh /opt/traccar-server/config-templates/traccar.xml \
    > /opt/traccar-server/conf/traccar.xml
if [[ -z "$OIDC_ISSUER_URL" ]]; then
    echo "\"OIDC_ISSUER_URL\" is not set. Removing OIDC configuration."
    sed --in-place "/<entry key=\"openid.[a-zA-Z]*\">.*<\/entry>/d" \
        /opt/traccar-server/conf/traccar.xml
fi

exec "$@"
