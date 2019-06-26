FROM alpine:3.8

RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.14.3/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl

RUN apk add --no-cache git

RUN apk add --no-cache curl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v3.0.0-pre/kustomize_3.0.0-pre_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && apk del curl

ENTRYPOINT [ "/usr/local/bin/kubectl" ]