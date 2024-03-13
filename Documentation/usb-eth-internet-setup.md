
---

# USB Ethernet Internet Sharing with BeagleBone Black

This guide provides detailed instructions on how to share your Linux host PC's internet connection with a BeagleBone Black (BBB) via USB Ethernet. This setup allows the BBB to access the internet through the host PC.

## Requirements

- A BeagleBone Black
- A Linux host PC with an internet connection (via Wi-Fi in this guide)
- A USB connection between the BBB and the host PC

## Configuration Steps

### Step 1: Enable IP Forwarding on Host PC

1. **Enable IP forwarding:**

```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

To make this permanent:

Edit `/etc/sysctl.conf` and ensure the following line is uncommented:

```bash
net.ipv4.ip_forward=1
```

Apply the changes:

```bash
sudo sysctl -p
```

2. **Set up IP masquerading:**

This step allows the BBB to access the internet through your host PC's Wi-Fi connection.

- `wlp3s0` is the WiFi adapter of my Host PC 
- `usb0` is the USB0 network port generated when the BBB is connected via USB cable and has the usb ethernet gadget enabled. 

```bash
sudo iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
sudo iptables -A FORWARD -i wlp3s0 -o usb0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i usb0 -o wlp3s0 -j ACCEPT
```

## IP Masquerading Overview

IP masquerading via `iptables` enables a device (like the BeagleBone Black) to access the internet through a host PC's connection, disguising the device's IP packets as originating from the host. Here's a breakdown:

1. `sudo iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE`
   - Masks outgoing packets from `usb0` (BBB) with the host's Wi-Fi IP, making external networks see these as originating from the host.

2. `sudo iptables -A FORWARD -i wlp3s0 -o usb0 -m state --state RELATED,ESTABLISHED -j ACCEPT`
   - Allows returning packets from established or related connections through the host to the BBB.

3. `sudo iptables -A FORWARD -i usb0 -o wlp3s0 -j ACCEPT`
   - Permits outgoing packets from the BBB to the internet, initiating connections.

This setup configures the host as a transparent bridge, routing and translating traffic between the BBB and the internet.

## Script

To automate the process this steps has been included in the script `share_internet.sh` in the host script section


### Step 2: Assign Static IP to BBB USB Interface on Host PC

Assign a static IP address to the `usb0` interface on your host PC. This IP will act as the gateway for the BBB.

```bash
ifconfig usb0 192.168.7.1 netmask 255.255.255.0 up
```

### Step 3: Configure BBB Network Settings

On the BBB, set the gateway to the static IP of the host PC and configure DNS.

1. **Set Static IP for BBB:**

```bash
ifconfig usb0 192.168.7.2 netmask 255.255.255.0 up
route add default gw 192.168.7.1
```

2. **Configure DNS Servers:**

Edit or create `/etc/resolv.conf` and add:

```bash
nameserver 8.8.8.8
nameserver 8.8.4.4
```

### Step 4: Testing the Connection

- **Ping the Host PC from BBB:**

```bash
ping 192.168.7.1
```

- **Ping an External Address:**

```bash
ping 8.8.8.8
ping google.com
```

Success in both tests indicates that your BBB is now connected to the internet via your host PC.

## Script

To automate the process this steps has been included in the script `setup_network.sh` in the host script section

## Troubleshooting Tips

- Ensure IP forwarding is enabled and correctly set up on your host PC.
- Check the iptables configurations for any errors or conflicts.
- Verify that the firewall settings on your host PC allow traffic through the `usb0` interface.
- Make sure there are no IP address conflicts with your network configuration.

## Conclusion

Following these steps will enable your BeagleBone Black to access the internet through a shared connection from your Linux host PC via USB Ethernet. This setup is particularly useful for environments where Wi-Fi or direct Ethernet connections are not available to the BBB.

---