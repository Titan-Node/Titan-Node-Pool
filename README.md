# Install Titan Node Pool on Linux
Download:
```
wget https://files.titan-node.com/Titan_Node_Pool_v1.17_Linux.tar.gz
```
Extract:
```
tar -zxvf Titan_Node_Pool_v1.17_Linux.tar.gz
```
Change Directory:
```
cd titan_node_pool
```
Run:
```
./titan
```

# Requirements
- Linux (built on Ubuntu 20.04)
- NVIDIA GPU (as many as you like, AMD not supported)
- Minimum 100 Mb/s Upload speed
- Ethernet LAN connection (wired)

# Patching
1. Check your NVIDIA card for session limits - Can be found under the "Max # of concurrent sessions" column. ([NVIDIA Matrix](https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new))

   NOTE: Titan Node software will try to automatically patch your driver if it detects a limit. If it fails, try step 2.

2. Manually patch your NVIDIA Driver to allow unlimited concurrent streams. ([Linux - Keylase Patch](https://github.com/keylase/nvidia-patch))

# Support
Join Discord for help and support:
[https://discord.gg/FbB89GDgkC](https://discord.gg/FbB89GDgkC)

Pool Dashboard:
[http://app.titan-node.com](http://app.titan-node.com)
