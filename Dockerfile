FROM madebytimo/scripts AS builder

RUN apt update -qq && apt install -y -qq unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/builder


RUN VERSION="$(download.sh --output - \
        "https://api.github.com/repos/traccar/traccar/releases/latest" \
        | sed --silent 's|^\s*"tag_name": "\(.*\)".*$|\1|p' \
        | head --lines 1)" \
    && download.sh --name traccar-server.zip \
    "https://github.com/traccar/traccar/releases/download/$VERSION/traccar-other-${VERSION#v}.zip" \
    && compress.sh --decompress traccar-server.zip \
    && rm traccar-server.zip conf/traccar.xml README.txt

FROM madebytimo/java

WORKDIR /opt/traccar-server
COPY --from=builder /root/builder .
COPY files/traccar.xml /opt/traccar-server/config-templates/traccar.xml
RUN chown user:user conf

ENV DATABASE_PASSWORD=""
ENV DATABASE_URL=""
ENV EMAIL_FROM=""
ENV EMAIL_HOST=""
ENV EMAIL_PASSWORD=""
ENV EMAIL_PORT="465"
ENV EMAIL_USERNAME=""
ENV FILTER_ACCURACY=""
ENV FILTER_SKIP_LIMIT=""
ENV FRONTEND_URL=""
ENV OIDC_ADMIN_GROUP=""
ENV OIDC_ALLOW_GROUP=""
ENV OIDC_CLIENT_ID=""
ENV OIDC_CLIENT_SECRET=""
ENV OIDC_FORCE=""
ENV OIDC_ISSUER_URL=""

COPY files/entrypoint.sh files/healthcheck.sh /usr/local/bin/

USER user
WORKDIR /opt/traccar-server/
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "java", "-jar", "tracker-server.jar", "conf/traccar.xml" ]

HEALTHCHECK CMD [ "healthcheck.sh" ]

LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/mbT-Infrastructure/docker-traccar-server"
