#!/bin/bash

METRICS_FILE="/home/ceciltat/monitoring2/09/metrics/index.html"

collect_metrics() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

    MEMORY_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    MEMORY_USED=$(free -m | awk '/Mem:/ {print $3}')
    MEMORY_AVAILABLE=$(free -m | awk '/Mem:/ {print $7}')

    DISK_TOTAL=$(df -k / | awk 'NR==2 {printf "%.1f", $2/1048576}')
    DISK_USED=$(df -k / | awk 'NR==2 {printf "%.1f", $3/1048576}')
    DISK_AVAILABLE=$(df -k / | awk 'NR==2 {printf "%.1f", $4/1048576}')

    cat <<EOF > $METRICS_FILE
# HELP cpu_usage CPU usage in percent
# TYPE cpu_usage gauge
cpu_usage $CPU_USAGE

# HELP memory_total Total memory in MB
# TYPE memory_total gauge
memory_total $MEMORY_TOTAL

# HELP memory_used Used memory in MB
# TYPE memory_used gauge
memory_used $MEMORY_USED

# HELP memory_available Available memory in MB
# TYPE memory_available gauge
memory_available $MEMORY_AVAILABLE

# HELP disk_total Total disk space in GB
# TYPE disk_total gauge
disk_total $DISK_TOTAL

# HELP disk_used Used disk space in GB
# TYPE disk_used gauge
disk_used $DISK_USED

# HELP disk_available Available disk space in GB
# TYPE disk_available gauge
disk_available $DISK_AVAILABLE
EOF
}


while true; do
    collect_metrics
    sleep 5  
done