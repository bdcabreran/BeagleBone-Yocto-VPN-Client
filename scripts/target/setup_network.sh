#!/bin/sh

# Static IP for the USB Ethernet interface on the BBB
BBB_IP="192.168.7.2"
# Gateway IP (Host PC's USB interface IP)
GATEWAY_IP="192.168.7.1"
# DNS server
DNS="8.8.8.8"
# Netmask 
NETMASK="255.255.255.0"

# Configure the USB Ethernet interface
ifconfig usb0 $BBB_IP netmask $NETMASK up

# Add default gateway
route add default gw $GATEWAY_IP

# Set DNS server
touch /etc/resolv.conf
echo "nameserver $DNS" |  tee /etc/resolv.conf > /dev/null

echo "Network configuration complete."
