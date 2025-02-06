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
    local current_date=$6
    local length=${#input}

    file_size_kb=${file_size//[^0-9]/} 
    [ "$length" -lt 4 ] && length=4

    # Переменная для подсчета сгенерированных имен
    declare -A generated
    generated_names=()  # Массив для хранения сгенерированных имен
    count=0

    # Генерация имен файлов
    while (( count < quantity )); do
        generate_names "$input" "$length" "" 0
        # Если сгенерировано достаточно комбинаций, завершаем
        if (( count >= quantity )); then
            break
        fi    
        # Если комбинаций недостаточно, увеличиваем длину
        ((length++))
    done

    # Создание файлов с уникальными именами
    for filename in "${generated_names[@]}"; do
        if ! check_disk_space; then
            echo "Skipping file creation due to low disk space."
            return 1
        fi
        local full_path="${directory}/${filename}_${current_date}.${ext}"
        dd if=/dev/zero of="$full_path" bs=1K count=$file_size_kb status=none
        echo "Created file: $full_path with size ${file_size_kb}KB"
        log_entry "FILE" "$full_path" "${file_size_kb}KB"
    done
}

create_objects() {
    local input=$1
    local quantity=$2
    local parent_directory=$3
    local current_date=$4
    local file_name_chars=$5
    local file_ext_chars=$6
    local file_quantity=$7
    local file_size=$8
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

    # Создание директорий с уникальными именами
    for dirname in "${generated_names[@]}"; do
        local dirname_with_date="${dirname}_${current_date}"
        mkdir -p "$parent_directory/$dirname_with_date"
        echo "Created directory: $parent_directory/$dirname_with_date"
        log_entry "DIR" "$parent_directory/$dirname_with_date" "N/A"

        if ! create_files "$file_name_chars" "$file_ext_chars" "$file_quantity" "$parent_directory/$dirname_with_date" "$file_size" "$current_date"; then
            return 1
        fi
    done
}

