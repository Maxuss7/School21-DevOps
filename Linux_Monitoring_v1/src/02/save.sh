#!/bin/bash

read -p "Save data? (Y/N): " ANSWER

if [[ "$ANSWER" =~ ^[Yy]$ ]]; then
	FILENAME=$(date +"%d_%m_%y_%H_%M_%S").status
	{
		echo "HOSTNAME = $HOSTNAME"
		echo "TIMEZONE = $TIMEZONE"
		echo "USER = $USER"
		echo "OS = $OS"
		echo "DATE = $DATE"
		echo "UPTIME = $UPTIME"
		echo "UPTIME_SEC = $UPTIME_SEC seconds"
		echo "IP = $IP"
		echo "MASK = $MASK"
		echo "GATEWAY = $GATEWAY"
		echo "RAM_TOTAL = $RAM_TOTAL"
		echo "RAM_USED = $RAM_USED"
		echo "RAM_FREE = $RAM_FREE"
		echo "SPACE_ROOT = $SPACE_ROOT"
		echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
		echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
	} > "$FILENAME"
	echo "Saved in $FILENAME"
else
	echo "Data was not saved."
fi