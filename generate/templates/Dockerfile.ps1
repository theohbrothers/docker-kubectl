@"
$(
($VARIANT['_metadata']['components'] | % {
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
# Note: `sops` does not provide binaries for other arch other than `linux/i386` and `linux/amd64`. So `sops` might not work on other architectures.
RUN wget -qO- https://github.com/mozilla/sops/releases/download/v3.7.1/sops-v3.7.1.linux > /usr/local/bin/sops && chmod +x /usr/local/bin/sops

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
}) -join ''
)
"@
