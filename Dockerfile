#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM alpine:3.5
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV VERSION="v0.5.2" \
    CGO_ENABLED="0"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN apk add --no-cache -U -t deps git go bash musl-dev \
    && git clone https://github.com/containernetworking/cni.git \
    && cd cni && git checkout tags/${VERSION} -b build \
    && ./build.sh && mkdir /cni-plugins; mv bin/* /cni-plugins \
    && apk del --purge deps && rm -rf /cni /var/cache/apk/*

#------------------------------------------------------------------------------
# Populate root file system:
#------------------------------------------------------------------------------

ADD rootfs /

#------------------------------------------------------------------------------
# Entrypoint:
#------------------------------------------------------------------------------

WORKDIR /cni-plugins
ENTRYPOINT ["/init"]
