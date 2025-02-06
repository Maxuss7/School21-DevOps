#!/bin/bash

make_log() {
    local date=$1
    local file=$2
    local num_entries=$((RANDOM % 901 + 100))

    for ((i = 0; i < num_entries; i++)); do
        ip=$(generate_ip)
        status=$(generate_status)
        method=$(generate_method)
        url=$(generate_url)
        agent=$(generate_agent)
        timestamp=$(date -d "$date +$((i % 1440)) minutes" +"%d/%b/%Y:%H:%M:%S %z")
        referer="-"  
        size=$((RANDOM % 1024 + 100))

        printf '%s - - [%s] "%s %s HTTP/1.1" %s %s "%s" "%s"\n' \
            "$ip" "$timestamp" "$method" "$url" "$status" "$size" "$referer" "$agent" >> "$file"
    done
}