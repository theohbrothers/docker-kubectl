FROM alpine:3.8
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

# kubectl
RUN apk add --no-cache curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v1.20.4/bin/$TARGETPLATFORM/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del curl



ENTRYPOINT [ "/usr/local/bin/kubectl" ]