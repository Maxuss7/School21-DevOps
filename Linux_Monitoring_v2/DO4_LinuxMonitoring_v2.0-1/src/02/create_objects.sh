#!/bin/bash

. logging.sh

check_disk_space() {
    local free_space=$(df -h / | awk 'NR==2 {print $4}')
    
    if [[ $free_space == *G ]]; then
        free_gb=${free_space%G}
    elif [[ $free_space == *M ]]; then
        free_gb=$(echo "scale=2; ${free_space%M} / 1024" | bc)
    else
        free_gb=0  
    fi

    if (( $(echo "$free_gb < 1.0" | bc -l) )); then
        echo "INFO: Script stopped. Only ${free_gb}GB available."
        log_entry "INFO:" "Script stopped. Low disk space: ${free_gb}GB left."
        return 1
    fi

    return 0
}

create_files() {
    local input=$1
    local ext=$2
    local quantity=$3
    local directory=$4
    local file_size=$5
    local length=${#input}

    file_size_mb=${file_size//[^0-9]/} 
    [ "$length" -lt 4 ] && length=4

    declare -A generated
    generated_names=()
    count=0

    while (( count < quantity )); do
        generate_names "$input" "$length" "" 0
        if (( count >= quantity )); then
            break
        fi    
        ((length++))
    done

    for filename in "${generated_names[@]}"; do
        if ! check_disk_space; then
            echo "Skipping file creation due to low disk space."
            return 1
        fi

        local full_path="${directory}_${current_date}/${filename}_${current_date}.${ext}"
        dd if=/dev/zero of="$full_path" bs=1M count=$file_size_mb status=none
        echo "Created file: $full_path with size ${file_size_mb}MB"
        log_entry "FILE" "$full_path" "${file_size_mb}MB"
    done
}

create_objects() {
    local input=$1
    local quantity=$2
    local parent_directory=$3
    local file_name_chars=$4
    local file_ext_chars=$5
    local file_size=$6

    local length=${#input}
    [ "$length" -lt 4 ] && length=4

    declare -A generated
    generated_names=()
    count=0

    # Генерация имен директорий
    while (( count < quantity )); do
        generate_names "$input" "$length" "" 0
        # Если сгенерировано достаточно комбинаций, завершаем
        if (( count >= quantity )); then
            break
        fi    
        # Если комбинаций недостаточно, увеличиваем длину
        ((length++))
    done

    # Создание директорий c файлами
    for dirname in "${generated_names[@]}"; do
        mkdir -p "${parent_directory}/${dirname}_${current_date}"
        echo "Created directory: ${parent_directory}/${dirname}_${current_date}"
        log_entry "DIR" "${parent_directory}/${dirname}_${current_date}" "N/A"
        if ! create_files "$file_name_chars" "$file_ext_chars" "$((RANDOM % 100 + 1))" "$parent_directory/$dirname" "$file_size"; then
            return 1
        fi

    done
}
