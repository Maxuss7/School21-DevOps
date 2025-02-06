#!/bin/bash

. validate_input.sh
. helpers.sh
. create_objects.sh
. logging.sh

main() {
    local directory=$1
    local dir_quantity=$2
    local dir_chars=$3
    local file_quantity=$4
    local file_chars=$5
    local file_size=$6
    local current_date=$(date +"%d%m%y")

    validate_input "$directory" "$dir_quantity" "$dir_chars" "$file_quantity" "$file_chars" "$file_size"

    IFS='.' read -r file_name_chars file_ext_chars <<< "$file_chars"

    LOG_FILE="creation_objects.log"
    init_log_file
    if ! create_objects "$dir_chars" "$dir_quantity" "$directory" "$current_date" \
                        "$file_name_chars" "$file_ext_chars" "$file_quantity" "$file_size" \
    ; then
        exit 0
    fi
}


main "$1" "$2" "$3" "$4" "$5" "$6"