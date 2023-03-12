@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# When `$TARGETPLATFORM is linux/arm/v7, strip out the '/v6' or '/v7' from it
RUN BIN_URL=https://storage.googleapis.com/kubernetes-release/release/$( $VARIANT['_metadata']['package_version'] )/bin/`$( echo `$TARGETPLATFORM | sed 's@/v[67]$@@' )/kubectl \
    && SHA512=`$( wget -qO- "`$BIN_URL.sha512" ) \
    && wget -qO- "`$BIN_URL"  > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && sha512sum /usr/local/bin/kubectl | grep "^`$SHA512 " \
    && kubectl version --client


"@

$VARIANT['_metadata']['components'] | % {
    $component = $_

    switch( $component ) {

        'envsubst' {
            @'
# From: https://github.com/nginxinc/docker-nginx/blob/1.17.0/stable/alpine/Dockerfile
# Bring in gettext so we can get `envsubst`, then throw
# the rest away. To do this, we need to install `gettext`
# then move `envsubst` out of the way so `gettext` can
# be deleted completely, then move `envsubst` back.
RUN apk add --no-cache --virtual .gettext gettext \
    && mv /usr/bin/envsubst /tmp/ \
    \
    && runDeps="$( \
        scanelf --needed --nobanner /tmp/envsubst \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --no-cache $runDeps \
    && apk del .gettext \
    && mv /tmp/envsubst /usr/local/bin/


'@
        }

        'git' {
            @'
RUN apk add --no-cache git


'@
        }

        'jq' {
            @'
RUN apk add --no-cache jq


'@
        }

        'kustomize' {
            @"
RUN apk add --no-cache curl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v2.0.3/kustomize_2.0.3_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && apk del curl


"@
        }

        'sops' {

            @"
RUN set -eux; \
    wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops; \
    chmod +x /usr/local/bin/sops; \
    sha256sum /usr/local/bin/sops | grep '^185348fd77fc160d5bdf3cd20ecbc796163504fd3df196d7cb29000773657b74 '; \
    sops --version

RUN apk add --no-cache gnupg


"@
        }

        'ssh' {
            @'
RUN apk add --no-cache openssh-client


'@
        }

        'sockets' {
            @'
# Sockets
# See: https://github.com/docker-library/php/issues/181#issuecomment-173365852
RUN docker-php-ext-install sockets


'@

        }

        'xdebug' {
            @'
# Xdebug: https://stackoverflow.com/questions/46825502/how-do-i-install-xdebug-on-dockers-official-php-fpm-alpine-image
# PHPIZE_DEPS: autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c
RUN apk add --no-cache --virtual .build-dependencies $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-source delete \
    && apk del .build-dependencies


'@

        }

        default {
            throw "No such component: $component"
        }
    }
}

@"
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

"@
