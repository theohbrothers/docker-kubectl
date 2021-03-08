FROM alpine:3.8

RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.21.0-beta.0/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl

RUN apk add --no-cache git



ENTRYPOINT [ "/usr/local/bin/kubectl" ]