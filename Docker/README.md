


*Note - You must install the nvidia drivers and nvidia container toolkit on your system.*
  - [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
  - [NVIDIA Driver Installation](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html)

If you do not wish to build the container manually, a nightly version is automatically built and deployed to dockerhub:
https://hub.docker.com/r/icsy7867/titan-node

This is a docker container to help run Titan-Node's binary for mining livepeer:
  - https://titan-node.com/
  - https://github.com/Titan-Node

**For a minimum deployment you need to specific your nickman and your Livepeer address:**
```
docker run --runtime nvidia  -itd --name titan-node \
    -e "ethAddr=0xXXXXXXXXXX" \
    -e "nickname=my-nickname" \
        icsy7867/titan-node:latest
```

**Additionally you can also specify which nvidia GPU to use:**
```
    -e "nvidia=0"
```
**And your max sessions:**
```
    -e "maxSessions=10"
```


**So using all variables:**
```
docker run  --runtime nvidia -itd --name titan-node \
    -e "ethAddr=0xXXXXXXXXXX" \
    -e "nickname=my-nickname" \
    -e "maxSessions=10" \
    -e "nvidia=0" \
        icsy7867/titan-node:latest
```

**To upgrade the container, simply pull the latest version:**
```
docker pull icsy7867/titan-node:latest
docker rm -f titan-node

docker run --runtime nvidia  -itd --name titan-node ...
```
