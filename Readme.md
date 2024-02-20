# traccar-server image

This Container image extends the [Java image](https://github.com/mbT-Infrastructure/docker-java).

This image contains a traccar-server installation. It allows configuration via environment
variables.

## Environment variables

-   `DATABASE_PASSWORD`
    -   Password for the database connection.
-   `DATABASE_URL`
    -   URL of the databse in the scheme `postgresql://HOST/DATABASE`.
-   `DATABASE_USERNAME`
    -   Username for the database connection.
-   `EMAIL_FROM`
    -   E-mail address to send e-mails from.
-   `EMAIL_HOST`
    -   Address of the SMTP host.
-   `EMAIL_PORT`
    -   Port of the e-mail protocol, default `465`.
-   `EMAIL_PASSWORD`
    -   Password to use for connecting to the e-mail host.
-   `EMAIL_USERNAME`
    -   Username to use for connecting to the e-mail host.
-   `FILTER_ACCURACY`
    -   Value for `filter.accuracy` configuration parameter.
-   `FILTER_SKIP_LIMIT`
    -   Value for `filter.skipLimit` configuration parameter.
-   `FRONTEND_URL`
    -   The base URL where the application is accessable.
-   `OIDC_ADMIN_GROUP`
    -   The group in the OIDC scope `groups` to grant admin access to.
-   `OIDC_CLIENT_ID`
    -   Client ID from the identity provider for OIDC.
-   `OIDC_CLIENT_SECRET`
    -   Client secret from the identity provider for OIDC.
-   `OIDC_FORCE`
    -   Set to `true` to only allow authentication via OIDC.
-   `OIDC_ISSUER_URL`
    -   Issuer URL of the identity provider.

## Development

To build and run for development run:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

To build the image locally run:

```bash
./docker-build.sh
```
