FROM alpine:3.8

RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.14.10/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl

RUN apk add --no-cache jq



ENTRYPOINT [ "/usr/local/bin/kubectl" ]