#!/bin/bash

cleanup_by_log() {
    log_file=$1
    if [[ -f "$log_file" ]]; then
        while IFS= read -r line; do
            file_or_dir=$(echo "$line" | awk -F, '{print $2}')
            if [[ -e "$file_or_dir" ]]; then
                rm -rf "$file_or_dir"
                echo "Удалено: $file_or_dir"
            fi
        done < "$log_file"
    else
        echo "Ошибка: Лог-файл $log_file не найден."
    fi
}

cleanup_by_time() {
    echo "Введите время начала (формат: YYYY-MM-DD HH:MM): "
    read start_time
    echo "Введите время окончания (формат: YYYY-MM-DD HH:MM): "
    read end_time

    start_timestamp=$(date -d "$start_time" +%s 2>/dev/null)
    end_timestamp=$(date -d "$end_time" +%s 2>/dev/null)

    if [[ -z "$start_timestamp" || -z "$end_timestamp" ]]; then
        echo "Ошибка: Неверный формат времени."
        return 1
    fi

    if [[ "$start_timestamp" -ge "$end_timestamp" ]]; then
        echo "Ошибка: Время начала должно быть раньше времени окончания."
        return 1
    fi

    find / -type f -newermt "$start_time" ! -newermt "$end_time" -exec rm -f {} \; 2>/dev/nul
    echo "Файлы, созданные между $start_time и $end_time, удалены."
}

cleanup_by_mask() {
    echo "Введите маску имени (например: *_2025*): "
    read mask
    if [[ "$mask" =~ ^[a-zA-Z0-9_*.-]+$ ]]; then
        find / -type f -name "$mask" -exec rm -f {} \; 2>/dev/null
        find / -type d -name "$mask" -exec rm -rf {} \; 2>/dev/null
        echo "Файлы и папки, соответствующие маске '$mask', удалены."
    else
        echo "Ошибка: Недопустимые символы в маске. Разрешены: буквы, цифры, _, *, ., -"
    fi
}