#!/bin/bash

validate_input() {
    local dir_chars=$1
    local file_chars=$2
    local file_size=$3
    IFS='.' read -r file_name_chars file_ext_chars <<< "$file_chars"

    for arg in "$@"; do
        if [ -z "$arg" ]; then
            echo "Usage: $0 <chars for folders> <chars for files> <file size>"
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

    if [[ ! $file_size =~ ^([0-9]+)[Mm][Bb]$ ]] || [ ${BASH_REMATCH[1]} -gt 100 ] || [ ${BASH_REMATCH[1]} -lt 1 ]; then
        echo "Error: Invalid file size. Use format 'NMb' where 1 <= N <= 100."
        exit 1
    fi
}