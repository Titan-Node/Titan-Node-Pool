FROM nvidia/cuda:12.0.0-base-ubuntu22.04

ENV	NVIDIA_DRIVER_CAPABILITIES=all

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    tar \
    pciutils \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

# Download and extract the Titan Node pool binary
RUN URL=$(curl https://github.com/Titan-Node/Titan-Node-Pool | grep gz | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | tail -1) && \
	VERSION=$(echo ${URL} | grep -Eo "v[0-9][.][0-9][0-9]") && \
	wget -O Titan_Node_Pool.tar.gz ${URL} && \
        tar -xzf Titan_Node_Pool.tar.gz && \
        rm Titan_Node_Pool.tar.gz && \
        mv ./titan /usr/local/bin && \
	chmod +x /usr/local/bin/titan

RUN mkdir /config

# Set the entrypoint to start the Titan Node pool binary with command line arguments
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
