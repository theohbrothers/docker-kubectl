@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

RUN apk add --no-cache ca-certificates

# When `$TARGETPLATFORM is linux/arm/v7, strip out the '/v6' or '/v7' from it
RUN BIN_URL=https://storage.googleapis.com/kubernetes-release/release/v$( $VARIANT['_metadata']['package_version'] )/bin/`$( echo `$TARGETPLATFORM | sed 's@/v[67]$@@' )/kubectl \
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
            $SOPS_VERSION = 'v3.9.0'
            Generate-DownloadBinary @{
                binary = 'sops'
                version = $SOPS_VERSION
                checksumsUrl = "https://github.com/getsops/sops/releases/download/$SOPS_VERSION/sops-$SOPS_VERSION.checksums.txt"
                archiveformat = ''
                testCommand = 'sops --version'
            }

            @"

RUN apk add --no-cache gnupg


"@
        }

        'ssh' {
            @'
RUN apk add --no-cache openssh-client


'@
        }

        'yq' {
            @'
RUN apk add --no-cache yq


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
