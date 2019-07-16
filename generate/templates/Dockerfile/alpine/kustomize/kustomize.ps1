@'
RUN apk add --no-cache curl \
    && curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v3.0.2/kustomize_3.0.2_linux_amd64 -o /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && apk del curl
'@
