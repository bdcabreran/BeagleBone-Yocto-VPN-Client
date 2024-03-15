#!/bin/sh

# Check internet connection
if ping -c 1 google.com &> /dev/null; then
  echo "Internet connection detected, proceeding with time synchronization."
  # Start the NTP daemon
  /etc/init.d/ntpd start
  # Wait a bit for time synchronization
  sleep 8
  # Print the updated date
  echo "Current system date: $(date)"
else
  echo "No internet connection detected. Please check your network settings."
fi
