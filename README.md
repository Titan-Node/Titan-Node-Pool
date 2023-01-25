# Install Titan Node Pool on Linux
Download:
```
sudo wget https://files.titan-node.com/Titan_Node_Pool_v1.25_Linux.tar.gz
```
Extract:
```
sudo tar -zxvf Titan_Node_Pool_v1.25_Linux.tar.gz
```
Run:
```
sudo ./titan
```

# Requirements
- Linux (built on Ubuntu 20.04)
- NVIDIA GPU (as many as you like, AMD not supported)
- Minimum 100 Mb/s Upload speed
- Ethernet LAN connection (wired)


# Install Nvidia Driver
If your Linux machine does not have a Nvidia driver installed, follow the instructions below.
If you already have a Nvidia driver installed but having issues, try the steps below. There have been reports of issues using the default `sudo apt install nvidia-driver-[version-number]` not working properly during the patching process. 

Install dkms:
```
sudp apt install dkms
```
Make directory and cd into it:
```
mkdir /opt/nvidia && cd /opt/nvidia
```
Download driver (currently using 515.57):
```
sudo wget https://international.download.nvidia.com/XFree86/Linux-x86_64/515.57/NVIDIA-Linux-x86_64-515.57.run
```
Make file executable:
```
sudo chmod +x ./NVIDIA-Linux-x86_64-515.57.run
```
Run driver installation:
```
sudo ./NVIDIA-Linux-x86_64-515.57.run
```

# Patching
1. Check your NVIDIA card for session limits - Can be found under the "Max # of concurrent sessions" column. ([NVIDIA Matrix](https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new))

   NOTE: Titan Node software will try to automatically patch your driver if it detects a limit. If it fails, try step 2.

2. Manually patch your NVIDIA Driver to allow unlimited concurrent streams using this link: ([Linux - Keylase Patch](https://github.com/keylase/nvidia-patch)) or follow the steps below:

Install zip unzip:
```
sudo apt install zip unzip
```
Download patch (compatable with any driver version):
```
sudo wget https://github.com/keylase/nvidia-patch/archive/refs/heads/master.zip
```
Unzip:
```
sudo unzip master.zip
```
Change into patch directory:
```
cd nvidia-patch-master
```
Make patch executable:
```
sudo chmod +x patch.sh
```
Run patch:
```
sudo ./patch.sh
```


# Stop Auto Update Nvidia Driver
If you've needed to patch your driver, we need to stop Nvidia from auto updating the driver. Any update will remove the patch and stops the transcoder from working.

Show list of all drivers on "Auto Update":
Note: Press `q` to exit.
```
apt-mark showauto | less
```
Find your driver name and put updates on hold (this example has driver v515.57):
```
apt-mark hold [driver-name]
```
Example:
```
apt-mark hold nvidia-kernel-common-515-server
apt-mark hold nvidia-kernel-source-515-server
```
Confirm the driver is on hold:
```
apt-mark showhold
```


# Support
Join Discord for help and support:
[https://discord.gg/FbB89GDgkC](https://discord.gg/FbB89GDgkC)

Pool Dashboard:
[http://app.titan-node.com](http://app.titan-node.com)
