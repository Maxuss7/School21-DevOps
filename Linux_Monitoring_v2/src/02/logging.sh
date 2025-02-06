#!/bin/bash

init_log_file() {
    LOG_FILE="creation_objects.log"
    echo "Type,Path,Date,Size" > "$LOG_FILE"
    start_time=$(date +%s)
    start_time_human=$(date +"%Y-%m-%d %H:%M:%S")
    echo "INFO: Script started at: $start_time_human" >> "$LOG_FILE"
}

log_entry() {
    local type=$1
    local path=$2
    local size=$3
    local date=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "$type,$path,$date,$size" >> "$LOG_FILE"
}

log_time_info() {
    end_time=$(date +%s)
    end_time_human=$(date +"%Y-%m-%d %H:%M:%S")
    duration=$((end_time - start_time))

    echo "Script started at: $start_time_human"
    echo "Script ended at:   $end_time_human"
    echo "Total execution time: $duration seconds"

    echo "INFO: Script ended at: $end_time_human" >> "$LOG_FILE"
    echo "INFO" "Total execution time: $duration seconds">> "$LOG_FILE"
}