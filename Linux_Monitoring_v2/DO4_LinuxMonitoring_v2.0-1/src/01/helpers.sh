#!/bin/bash

contains_all_chars() {
    local input=$1
    local current=$2

    for (( i=0; i<${#input}; i++ )); do
        if [[ "$current" != *"${input:$i:1}"* ]]; then
            return 1
        fi
    done
    return 0
}

generate_names() {
    local input=$1
    local length=$2
    local current=$3
    local index=$4
    local i

    if [ ${#current} -eq "$length" ]; then
        if contains_all_chars "$input" "$current"; then
            if [[ -z "${generated[$current]}" ]]; then
                generated_names+=("$current")  # Добавляем сгенерированное имя в массив
                generated[$current]=1
                ((count++))
                if (( count >= quantity )); then
                    return 0  # Если количество нужных слов найдено, выходим
                fi
            fi
        fi
        return
    fi

    for (( i=index; i<${#input}; i++ )); do
        local char="${input:$i:1}"
        generate_names "$input" "$length" "$current$char" "$i"
        if (( count >= quantity )); then
            return 0
        fi
    done
}
