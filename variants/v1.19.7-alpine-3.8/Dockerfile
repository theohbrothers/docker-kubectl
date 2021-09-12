FROM alpine:3.8
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

# When $TARGETPLATFORM is linux/arm/v7, strip out the '/v7' from it
RUN wget -qO- https://storage.googleapis.com/kubernetes-release/release/v1.19.7/bin/$( echo $TARGETPLATFORM | sed 's@/v7$@@' )/kubectl > /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

ENTRYPOINT [ "/usr/local/bin/kubectl" ]
