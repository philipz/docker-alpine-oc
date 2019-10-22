FROM alpine:3.10

ENV OC_VERSION=v3.11.0 \
    OC_TAG_SHA=0cbc58b \
    BUILD_DEPS='tar gzip' \
    RUN_DEPS='curl ca-certificates gettext'

RUN apk --no-cache add ca-certificates $BUILD_DEPS $RUN_DEPS && \
    curl -sLo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    curl -sLo /tmp/glibc-2.30-r0.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
    apk add /tmp/glibc-2.30-r0.apk && \
    curl -sLo /tmp/oc.tar.gz https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit.tar.gz && \
    tar xzvf /tmp/oc.tar.gz -C /tmp/ && \
    mv /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit/oc /usr/local/bin/ && \
    rm -rf /tmp/oc.tar.gz /tmp/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG_SHA}-linux-64bit && \
    apk del $BUILD_DEPS

CMD ["/usr/local/bin/oc"]
