@"
FROM $( $VARIANT['_metadata']['distro'] ):$( $VARIANT['_metadata']['distro_version'] )
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on `$BUILDPLATFORM, building for `$TARGETPLATFORM"

# kubectl
RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/$( $VARIANT['_metadata']['package_version'] )/bin/`$TARGETPLATFORM/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl
"@
