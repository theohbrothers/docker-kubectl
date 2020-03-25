@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )

RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$( $VARIANT['_metadata']['package_version'] )/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl
"@
