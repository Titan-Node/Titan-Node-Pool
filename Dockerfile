FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ENV	NVIDIA_DRIVER_CAPABILITIES=all

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    psmisc \
    pciutils \
    && rm -rf /var/lib/apt/lists/*

# Download and extract the Titan Node pool binary
RUN wget https://files.titan-node.com/Titan_Node_Pool_v1.34_Linux.tar.gz && \
    tar -xzf Titan_Node_Pool_v1.34_Linux.tar.gz && \
    rm Titan_Node_Pool_v1.34_Linux.tar.gz && \
    mv ./titan /usr/local/bin

# Set the entrypoint to start the Titan Node pool binary with command line arguments
ENTRYPOINT ["/usr/local/bin/titan"]
