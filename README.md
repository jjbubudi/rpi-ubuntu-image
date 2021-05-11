# Overview
Pre-built Ubuntu 20.04 arm64 server image for Raspberry Pi 4B USB Boot

# Tweaks Applied
This image is targeting headless server usage
1. Auto decompress the kernel
1. cgroups enabled by default
1. gpu_mem set to 16 (minimum) to maximize available memory

# Build (Only for Linux / MacOS / WSL2)
Make sure Docker is installed, and then run
```shell
docker run -it --rm --privileged -v /dev:/dev -v ${PWD}:/build mkaczanowski/packer-builder-arm build build.pkr.hcl
```

# Credits
- **James Chambers** for the amazing guide: https://jamesachambers.com/raspberry-pi-4-ubuntu-20-04-usb-mass-storage-boot-guide/
- **Mateusz Kaczanowski** for the amazing Packer builder plugin: https://github.com/mkaczanowski/packer-builder-arm
