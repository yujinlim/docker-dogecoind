# dogecoind for docker
[![Docker Stars](https://img.shields.io/docker/stars/yujinlim/dogecoind.svg?style=flat-square)]() [![Docker Pulls](https://img.shields.io/docker/pulls/yujinlim/dogecoind.svg?style=flat-square)]() [![](https://images.microbadger.com/badges/image/yujinlim/dogecoind.svg?style=flat-square)](https://microbadger.com/images/yujinlim/dogecoind "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/yujinlim/dogecoind.svg?style=flat-square)](https://microbadger.com/images/yujinlim/dogecoind "Get your own version badge on microbadger.com")

Docker file for dogecoind

## Getting started
```bash
# this will generate conf file by default
# not recommend only to run this way, always set your own username and password
docker run yujinlim/dogecoind

# with commands
docker run --rm -it yujinlim/dogecoind -rpcuser=user -rpcpassword=password -printtoconsole
```

## Development
### Requirements
- Vagrant

### Getting started
```bash
vagrant up

vagrant ssh

cd /vagrant

# build docker image
make build
```
