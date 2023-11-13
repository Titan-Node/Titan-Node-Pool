# Containerized Operation - Experimental

This directory provides a Docker-based setup for the Titan Node pool. It includes a [Dockerfile](docker/Dockerfile) and a [docker-compose.yml](docker/docker-compose.yml) file.

## Prerequisites

Before you start, make sure you have the following dependencies installed on your system:

1. **Nvidia Drivers**: Your system should have the latest Nvidia drivers. Refer to the [official Nvidia driver installation documentation](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html) for instructions.

2. **Docker**: Docker should be installed on your system. Follow the [official Docker installation documentation](https://docs.docker.com/engine/install/ubuntu/) for guidance.

3. **Nvidia Container Toolkit Integration**: Your system needs to have the [Nvidia container toolkit](https://github.com/NVIDIA/nvidia-container-toolkit) installed.

## Usage

### DockerHub Deployment

A nightly version of the container is available on DockerHub, courtesy of @icsy7867. This version is automatically built and deployed.

To deploy the minimum setup, specify your nickname and Livepeer address:

```bash
docker run --runtime nvidia  -itd --name titan-node \
    -e "ethAddr=0xXXXXXXXXXX" \
    -e "nickname=my-nickname" \
        icsy7867/titan-node:latest
```

You can also specify which Nvidia GPU to use:

```bash
    -e "nvidia=0"
```

And set your max sessions:

```bash
    -e "maxSessions=10"
```

If you want to use a local `config` folder you can mount it to the container:

```bash
    -v /path/to/config:/config
```

To use all variables:

```bash
docker run  --runtime nvidia -itd --name titan-node \
    -e "ethAddr=0xXXXXXXXXXX" \
    -e "nickname=my-nickname" \
    -e "maxSessions=10" \
    -e "nvidia=0" \
        icsy7867/titan-node:latest
```

To upgrade the container, pull the latest version:

```bash
docker pull icsy7867/titan-node:latest
docker rm -f titan-node

docker run --runtime nvidia  -itd --name titan-node ...
```

### Manual Build

If you prefer to manually build the container, follow these steps:

1. Clone this repository to your local system and navigate to the `docker` directory.
2. Build the Docker image: `docker build -t titan-node .`
3. Run the container:

```bash
docker run --runtime nvidia -itd --name titan-node \
    -e "ethAddr=0xXXXXXXXXXX" \
    -e "nickname=my-nickname" \
    -e "maxSessions=10" \
    -e "nvidia=0" \
        titan-node
```

> [!NOTE]\
> If you prefer running the container in the background, use Docker Compose:
>
> ```bash
> docker compose up -d
> ```
>
> Make sure to update the [docker-compose.yml](docker/docker-compose.yml) file with your ETH address, orchestrator secret, and max sessions count.
