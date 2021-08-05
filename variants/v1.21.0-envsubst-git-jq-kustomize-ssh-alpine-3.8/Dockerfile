FROM alpine:3.8
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

# kubectl
RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.21.0/bin/$TARGETPLATFORM/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl

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

RUN apk add --no-cache git

RUN apk add --no-cache jq

RUN apk add --no-cache curl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v2.0.3/kustomize_2.0.3_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && apk del curl

RUN apk add --no-cache openssh-client



ENTRYPOINT [ "/usr/local/bin/kubectl" ]