FROM alpine:3.8

RUN apk add --no-cache curl \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.3/bin/linux/amd64/kubectl -o /kubectl \
    && chmod +x /kubectl \
    && apk del curl

RUN apk add --no-cache git

