#!/bin/bash

validate_input() {
    local directory=$1
    local dir_quantity=$2
    local dir_chars=$3
    local file_quantity=$4
    local file_chars=$5
    local file_size=$6
    
    for arg in "$@"; do
        if [ -z "$arg" ]; then
            echo "Usage: $0 <path> <number of folders> <chars for folders> <number of files> <chars for files> <file size>"
            exit 1
        fi
    done

    if [ ${#dir_chars} -gt 7 ]; then
        echo "Error: Folder chars exceed 7 characters."
        exit 1
    fi

    IFS='.' read -r file_name_chars file_ext_chars <<< "$file_chars"
    if [ -z "$file_name_chars" ] || [ -z "$file_ext_chars" ]; then
        echo "Error: File pattern must be in 'abc.def' format."
        exit 1
    fi

    if [ ${#file_name_chars} -gt 7 ]; then
        echo "Error: File name chars exceed 7 characters."
        exit 1
    fi

    if [ ${#file_ext_chars} -gt 3 ]; then
        echo "Error: File extension chars exceed 3 characters."
        exit 1
    fi

    if [[ ! $file_size =~ ^([0-9]+)kb$ ]] || [ ${BASH_REMATCH[1]} -gt 100 ] || [ ${BASH_REMATCH[1]} -lt 1 ]; then
        echo "Error: Invalid file size. Use format 'Nkb' where 1 <= N <= 100."
        exit 1
    fi

    if ! [[ $dir_quantity =~ ^[0-9]+$ ]] || [ "$dir_quantity" -le 0 ]; then
        echo "Error: Invalid folder count. Must be a positive integer."
        exit 1
    fi

    if ! [[ $file_quantity =~ ^[0-9]+$ ]] || [ "$file_quantity" -le 0 ]; then
        echo "Error: Invalid file count. Must be a positive integer."
        exit 1
    fi
}