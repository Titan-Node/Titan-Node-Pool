[![Titan-Node-Pool](https://raw.githubusercontent.com/Titan-Node/Titan-Node-Pool/main/Livepeer%20Video%20Mining%20Pool.png)]([https://github.com/livepeer/go-livepeer](https://github.com/Titan-Node/Titan-Node-Pool))


Start video mining on Livepeer by joining the Titan Node Pool.

Earn ETH, LPT and LTNT for transcoding live video into multiple resolutions for Livepeer connected applications.

Pool Dashboard:
[http://app.titan-node.com](http://app.titan-node.com)


##### Table of Contents
- [Requirements](#requirements)
- [Install Titan Node Pool on Linux](#install-titan-node-pool-on-linux)
- [Run as system service (optional)](#run-as-system-service-optional)
- [List Of Arguments](#list-of-arguments)
- [Install Nvidia Driver (if required)](#install-nvidia-driver-if-required)
- [Patching (if required)](#patching-if-required)
- [Stop Auto Update Nvidia Driver (if required)](#stop-auto-update-nvidia-driver-if-required)
- [Containerized Operation (Experimental)](#containerized-operation-experimental)
- [Support](#support)




# Requirements
- Linux (built on Ubuntu 18.04)
- NVIDIA GPU (as many as you like, AMD not supported)
- Minimum 100 Mb/s Upload speed
- Ethernet LAN connection (wired)


# Install Titan Node Pool on Linux
Download:
```
sudo wget https://files.titan-node.com/Titan_Node_Pool_v1.38_Linux.tar.gz
```
Extract:
```
sudo tar -zxvf Titan_Node_Pool_v1.38_Linux.tar.gz
```
Run:
```
sudo ./titan
```

# Run as system service (optional)
Create a systemd unit file to define your `titan.service` configuration:
```
sudo nano /etc/systemd/system/titan.service
```
Paste the following example configuration into the file and update `ethAddr` and `nickname`.

_Assuming `titan` executable is in a directory `/root/titan/`_:
```
[Unit]
Description=Titan Node Pool service
Wants=network-online.target
After=network-online.target
Documentation=https://github.com/Titan-Node/Titan-Node-Pool

[Service]
Type=simple
User=root
Restart=on-failure
RestartSec=3
TimeoutStopSec=900
ExecStart=/root/titan/titan \
   -nvidia all \
   -configPath /root/titan/config \
   -ethAddr 0x0000000000000000000000000000000000000000 \
   -nickname HelloWorld \
   -enableAutoPatch True

[Install]
WantedBy=multi-user.target
```
_To exit and save, press `Ctrl` + `X`, then `Y`, then `Enter`._

Run daemon-reload and enable titan service.
```
sudo systemctl daemon-reload
sudo systemctl enable titan
```
Start the titan service and check it's status.
```
sudo systemctl start titan
sudo systemctl status titan
```
To view the logs:
```
sudo journalctl -fu titan
```
To stop the service:
```
sudo systemctl stop titan
```

# List Of Arguments
```
options:
  -h, --help            show this help message and exit
  -nvidia string        Comma-separated list of Nvidia GPU device IDs i.e 0,1,2 (or "all" for all available devices).
  -maxSessions int      Maximum number of concurrent transcoding sessions for transcoder.
  -v int                Log verbosity. {4|5|6}
  -configPath string    Path to config files.
  -ethAddr string       Ethereum address for payouts.
  -nickname string      Nickname to identify node on dashboard.
  -disableAutoStartup bool
                        Disables auto startup prompt for Windows. Turn this on if you are running as system service.
  -enableAutoPatch bool
                        Enables auto patching of nvidia driver without need of prompt. Turn this on if you are running as system service.
  -GUIPrompt bool       Passes prompt to GUI program for Windows. Leave this off if you are running Titan from the command line.
```

# Install Nvidia Driver (if required)
If your Linux machine does not have a Nvidia driver installed, follow the instructions below.
If you already have a Nvidia driver installed but having issues, try the steps below. There have been reports of issues using the default `sudo apt install nvidia-driver-[version-number]` not working properly during the patching process.

Install dkms:
```
sudo apt install dkms
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

# Patching (if required)
1. Check your NVIDIA card for session limits - Can be found under the "Max # of concurrent sessions" column. ([NVIDIA Matrix](https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new))

   NOTE: Titan Node software will try to automatically patch your driver if it detects a limit. If it fails, try step 2.

2. Manually patch your NVIDIA Driver to allow unlimited concurrent streams using this link: ([Linux - Keylase Patch](https://github.com/keylase/nvidia-patch)) or follow the steps below:

Download patch (compatable with any driver version):

Check driver is running:
```
nvidia-smi
```
*Output should show no errors and details about your driver and GPU.*

Download patch:
```
sudo wget https://raw.githubusercontent.com/keylase/nvidia-patch/master/patch.sh
```
Make patch executable:
```
sudo chmod +x patch.sh
```
Run patch:
```
sudo ./patch.sh
```


# Stop Auto Update Nvidia Driver (if required)
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

# Containerized Operation (Experimental)

Within this repository, you'll discover a [Dockerfile](docker/Dockerfile) and [docker-compose.yml](docker/docker-compose.yml) file, offering a method to encapsulate the Titan Node pool within a Docker container. It's essential to note that this configuration is still in the experimental phase and isn't recommended for production environments. For more information, check out the [README](docker/README.md) in the Docker directory

# Support
Join Discord for help and support:
[https://discord.gg/FbB89GDgkC](https://discord.gg/FbB89GDgkC)
