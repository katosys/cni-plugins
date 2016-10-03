#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM alpine:3.4
MAINTAINER Marc Villacorta Morera <marc.villacorta@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV VERSION="v0.3.0" \
    CGO_ENABLED="0"

#------------------------------------------------------------------------------
# Install:
#------------------------------------------------------------------------------

RUN apk add --no-cache --update -t deps git go bash \
    && git clone https://github.com/containernetworking/cni.git \
    && cd cni; git checkout tags/${VERSION} -b ${VERSION} \
    && ./build; mkdir /cni-plugins; mv bin/* /cni-plugins \
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
