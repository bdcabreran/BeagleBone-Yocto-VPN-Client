#!/bin/sh

# Function to check internet connectivity
check_internet() {
    wget -q --spider http://google.com

    if [ $? -eq 0 ]; then
        echo "Internet is connected."
        return 0
    else
        echo "No internet connection."
        return 1
    fi
}

# Main script execution starts here
if check_internet; then
    echo "Loading tun module..."
    modprobe tun

    echo "Executing update-time script..."
    /usr/bin/update-time.sh

    echo "Starting OpenVPN..."
    openvpn --config /usr/bin/client1.ovpn
else
    echo "Skipping operations due to lack of internet connectivity."
fi
