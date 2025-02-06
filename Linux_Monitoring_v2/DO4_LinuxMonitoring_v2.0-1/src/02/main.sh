#!/bin/bash

. validate_input.sh
. helpers.sh
. create_objects.sh
. logging.sh

main() {
    local dir_chars=$1
    local file_chars=$2
    local file_size=$3
    local current_date=$(date +"%d%m%y")

    validate_input "$dir_chars" "$file_chars" "$file_size"

    current_date=$(date +"%d%m%y")
    init_log_file

    IFS='.' read -r file_name_chars file_ext_chars <<< "$file_chars"

    find / -type d -writable \
        -not \( -path "*/bin/*" -o -path "*/sbin/*" \) \
        2>/dev/null | while read -r base_dir; do

        if ! create_objects "$dir_chars" "$((RANDOM % 100 + 1))" "$base_dir" "$file_name_chars" \
            "$file_ext_chars" "$file_size"; then
            log_time_info
            exit 0
        fi
    done


}

main "$1" "$2" "$3"