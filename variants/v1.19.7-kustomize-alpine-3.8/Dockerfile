FROM alpine:3.8

RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.19.7/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl

RUN apk add --no-cache curl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v2.0.3/kustomize_2.0.3_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && apk del curl



ENTRYPOINT [ "/usr/local/bin/kubectl" ]