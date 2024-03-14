#!/bin/sh
### BEGIN INIT INFO
# Provides:          setup_network
# Required-Start:    $network $remote_fs
# Required-Stop:     $network $remote_fs
# Default-Start:     S
# Default-Stop:      0 1 6
# Short-Description: Sets up BBB network configuration
### END INIT INFO

# Static IP for the USB Ethernet interface on the BBB
BBB_IP="192.168.7.2"
# Gateway IP (Host PC's USB interface IP)
GATEWAY_IP="192.168.7.1"
# DNS server
DNS="8.8.8.8"
# Netmask 
NETMASK="255.255.255.0"

start() {
    echo "Configuring network..."
    ifconfig usb0 $BBB_IP netmask $NETMASK up
    route add default gw $GATEWAY_IP
    touch /etc/resolv.conf
    echo "nameserver $DNS" | tee /etc/resolv.conf > /dev/null
    echo "Network configuration complete."
}

stop() {
    echo "Stopping network configuration..."
    # Implement network stop logic if needed
}

case "$1" in 
    start)
       start
       ;;
    stop)
       stop
       ;;
    restart|reload)
       stop
       start
       ;;
    *)
       echo "Usage: $0 {start|stop|restart}"
       exit 1
esac

exit 0
