#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl | awk '/Time zone/ {print $3, $4, $5}')
USER=$(whoami)
OS=$(cat /etc/issue | tr -d '\\n\\l')
DATE=$(date +"%d %b %Y %T")
UPTIME=$(uptime -p | cut -d' ' -f2-)
UPTIME_SEC=$(uptime -p | awk '{print ($2*3600)+($4*60)}')
IP_AND_MASK=$(ip -4 a s enp0s3 | awk '/inet/ {print $2}')
IP=${IP_AND_MASK%%/*}
MASK=$(ipcalc -n 0.0.0.0/${IP_AND_MASK##*/} | awk '/Netmask/ {print $2}')
GATEWAY=$(ip r | awk '/default/ {print $3}')
RAM_TOTAL=$(free -m | awk '/Mem:/ {printf "%.3f GB", $2/1024}')
RAM_USED=$(free -m | awk '/Mem:/ {printf "%.3f GB", $3/1024}')
RAM_FREE=$(free -m | awk '/Mem:/ {printf "%.3f GB", $4/1024}')
SPACE_ROOT=$(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')
SPACE_ROOT_USED=$(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')
SPACE_ROOT_FREE=$(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')

