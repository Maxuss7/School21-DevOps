#!/bin/bash

init_log_file() {
    echo "Type,Path,Date,Size" > "$LOG_FILE"
}

log_entry() {
    local type=$1
    local path=$2
    local size=$3
    local date=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "$type,$path,$date,$size" >> "$LOG_FILE"
}
