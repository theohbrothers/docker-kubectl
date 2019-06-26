@'
RUN apk add --no-cache curl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v3.0.0-pre/kustomize_3.0.0-pre_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && apk del curl
'@
