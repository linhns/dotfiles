#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: attach-cam.sh <camera busid>"
    exit 1
fi
sudo usbip list --remote=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
sudo usbip attach --remote=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}') --busid=$1 
