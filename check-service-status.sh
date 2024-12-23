#!/bin/bash
read -p "Enter the service you want to check or start running: " SERVICE
# Check if the systemctl is running, if not start it
if systemctl is-active --quiet $SERVICE; then
	echo "$SERVICE is running"
else
	echo "$SERVICE is not running"
	systemctl start $SERVICE
	echo "$SERVICE has been started"
fi