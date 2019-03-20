FROM alpine

LABEL maintainer="Elvis"
ENV GOPATH=/go \
    PROJ_DIR=github.com/btcsuite/btcd

RUN apk add --no-cache git go musl-dev \
    && mkdir -p $GOPATH/src && cd $GOPATH/src \
    && go get -v $PROJ_DIR \
    && cd $PROJ_DIR \
    && go build \
    && go install . ./cmd/... \
    && apk del git go musl-dev \
    && rm -rf /apk /tmp/* /var/cache/apk/* $GOPATH/src/*

EXPOSE 8333 8334
CMD ["/go/bin/btcd", "--help"]

