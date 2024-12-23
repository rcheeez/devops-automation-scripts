#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi 

# Update system packages and clean up unnecessary packages
echo "Starting system update and cleanup process..."

# Update system packages and clean up unnecessary packages
apt-get update && apt-get upgrade -y && apt-get autoremove -y && apt-get clean

echo "System Packages Updated and Cleaned Up"
