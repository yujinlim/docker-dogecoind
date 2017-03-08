# dogecoind for docker
[![Docker Stars](https://img.shields.io/docker/stars/yujinlim/dogecoind.svg?style=flat-square)]() [![Docker Pulls](https://img.shields.io/docker/pulls/yujinlim/dogecoind.svg?style=flat-square)]() [![](https://images.microbadger.com/badges/image/yujinlim/dogecoind.svg?style=flat-square)](https://microbadger.com/images/yujinlim/dogecoind "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/yujinlim/dogecoind.svg?style=flat-square)](https://microbadger.com/images/yujinlim/dogecoind "Get your own version badge on microbadger.com")

Docker file for dogecoind

## Getting started
### Usage with docker
```bash
# this will generate conf file by default
# not recommend only to run this way, always set your own username and password
docker run yujinlim/dogecoind

# with commands
docker run --rm -it yujinlim/dogecoind -rpcuser=user -rpcpassword=password -printtoconsole
```

### Usage with kubernetes
```yaml
# dogecoin/replication.yml
apiVersion: v1
kind: ReplicationController
metadata:
  name: dogecoin
spec:
  replicas: 1
  template:
    metadata:
      name: dogecoin
      labels:
        app: dogecoin
    spec:
      containers:
      - name: dogecoin
        image: yujinlim/dogecoind
        ports:
        - containerPort: 22555
        - containerPort: 22556
        args: ["-txindex", "-rpcallowip=::/0", "-printtoconsole", "-disablewallet", "-conf=/etc/opt/dogecoin/dogecoin.conf"]
        volumeMounts:
        - name: dogecoin-conf
          mountPath: /etc/opt/dogecoin
        - name: dogecoin-dir
          mountPath: /dogecoin
      volumes:
      - name: dogecoin-conf
        secret:
          secretName: dogecoin-secret
      - name: dogecoin-dir
        hostPath:
          path: /data/dogecoin
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
