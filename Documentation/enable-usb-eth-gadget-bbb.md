
---

# Enabling USB Ethernet Gadget on BeagleBone using Yocto

This guide outlines the steps to enable the USB Ethernet gadget drivers in the Linux kernel for a BeagleBone board using the Yocto Project. It includes configuring the kernel with `menuconfig`, compiling the kernel, creating a bootable SD card, and enabling the USB Ethernet interface on the device.

## Prerequisites

- Yocto Project environment set up for BeagleBone
- Basic understanding of Linux kernel configuration and compilation
- Access to a BeagleBone board

## Steps

### 1. Opening `menuconfig`

From your Yocto Project build environment, execute the following command to open the `menuconfig` interface for kernel configuration:

```bash
bitbake -c menuconfig virtual/kernel
```

### 2. Enabling USB Ethernet Drivers

In `menuconfig`, follow these steps to enable USB Ethernet drivers:

1. Use the search functionality by pressing `/` and type `CONFIG_USB_ETH` to find the USB Ethernet options.
2. Navigate through the paths given in the search results to find USB Ethernet configurations:
    - Go to `Device Drivers` -> `USB Support` -> `USB Gadget Support` -> `USB Gadget Precomposed Configurations` -> `Ethernet Gadget`.
3. Enable `USB_ETH`, `USB_ETH_EEM`, and `USB_ETHRNDIS` by marking them with `y` (yes) to build them into the kernel.
4. Save your configuration and exit `menuconfig`.

### 3. Compiling the Kernel

After configuring, compile the kernel or the entire image by running:

```bash
bitbake virtual/kernel
```

or, if you're building a specific image:

```bash
bitbake core-image-minimal
```

### 4. Creating a Bootable SD Card

Once the compilation is complete, create a bootable SD card with the generated images. Follow `write-to-sdcard.md` guide

### 5. Enabling the USB Ethernet Gadget on the Device

After booting your BeagleBone with the new image:

1. Load the `g_ether` module:

    ```bash
    modprobe g_ether
    ```

2. Bring up the `usb0` interface:
    ```bash
    ifconfig usb0 up
    ```


### 6. Verify network device 
list available network devices and locate `usb0` device:




```bash
root@beaglebone-yocto:/# ifconfig

usb0      Link encap:Ethernet  HWaddr D6:7D:99:A6:31:81  
        inet6 addr: fe80::d47d:99ff:fea6:3181/64 Scope:Link
        UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
        RX packets:40 errors:0 dropped:0 overruns:0 frame:0
        TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
        collisions:0 txqueuelen:1000 
        RX bytes:5696 (5.5 KiB)  TX bytes:552 (552.0 B)
```

## Conclusion

Following these steps should enable the USB Ethernet gadget functionality on your BeagleBone board, allowing you to establish a network connection over USB. This can be particularly useful for debugging or when a standard Ethernet connection is not available.

## Next Steps 

The next step is related to share internet between host and beaglebone board using the driver we just enable, for this follow the guide [usb-eth-internet-setup](usb-eth-internet-setup.md)


---

