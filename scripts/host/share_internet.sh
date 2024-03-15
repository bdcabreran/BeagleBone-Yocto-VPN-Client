#!/bin/bash

# Name of the internet-facing interface
INTERNET_IFACE="wlp3s0"
# Name of the USB Ethernet interface
USB_IFACE="usb0"
# Netmask 
NETMASK="255.255.255.0"
# Set Static IP (This IP will act as the gateway for the BBB.)
STATIC_IP="192.168.7.1"

# Enable IP forwarding
echo "Enabling IP forwarding..."
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward

# Set up IP masquerading
echo "Setting up IP masquerading for $INTERNET_IFACE to $USB_IFACE..."
sudo iptables -t nat -A POSTROUTING -o $INTERNET_IFACE -j MASQUERADE
sudo iptables -A FORWARD -i $INTERNET_IFACE -o $USB_IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $USB_IFACE -o $INTERNET_IFACE -j ACCEPT

sudo ifconfig usb0 $STATIC_IP netmask $NETMASK up

echo "Internet sharing setup complete."
