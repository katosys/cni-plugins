# docker-cni-plugins

[![Build Status](https://travis-ci.org/katosys/docker-cni-plugins.svg?branch=master)](https://travis-ci.org/katosys/docker-cni-plugins)

Container network interface plugins

This will copy the plugins to `/tmp/cni`:
```
docker run -it \
  --volume /tmp/cni:/tmp \
  katosys/cni-plugins:v0.3.0-1
```
