#!/bin/bash

. generate_fields.sh
. make_log.sh

for day in {1..5}; do
    date=$(date -d "2025-01-$day" +"%Y-%m-%d")
    log_file="nginx_access_$date.log"
    echo "Генерация логов за $date в файл $log_file..."
    make_log "$date" "$log_file"
done

echo "Генерация логов завершена."