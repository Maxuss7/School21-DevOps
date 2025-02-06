#!/bin/bash

generate_ip() {
    echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}

# 200 OK:
#     Запрос успешно обработан. Сервер возвращает запрошенные данные.
# 201 Created:
#     Запрос успешно выполнен, и на сервере создан новый ресурс (например, после POST-запроса).
# 400 Bad Request:
#     Сервер не может обработать запрос из-за ошибки на стороне клиента (например, неверный синтаксис запроса).
# 401 Unauthorized:
#     Для доступа к ресурсу требуется аутентификация. Клиент не предоставил корректные учетные данные.
# 403 Forbidden:
#     Сервер понимает запрос, но отказывается его выполнять из-за ограничений доступа.
# 404 Not Found:
#     Сервер не может найти запрошенный ресурс.
# 500 Internal Server Error:
#     Общая ошибка сервера. Сервер не смог обработать запрос из-за внутренней ошибки.
# 501 Not Implemented:
#     Сервер не поддерживает функциональность, необходимую для выполнения запроса.
# 502 Bad Gateway:
#     Сервер, действуя как шлюз или прокси, получил недопустимый ответ от вышестоящего сервера.
# 503 Service Unavailable:
#     Сервер временно недоступен (например, из-за перегрузки или технического обслуживания).
generate_status() {
    local codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
    echo "${codes[$((RANDOM % ${#codes[@]}))]}"
}

generate_method() {
    local methods=("GET" "POST" "PUT" "PATCH" "DELETE")
    echo "${methods[$((RANDOM % ${#methods[@]}))]}"
}

generate_url() {
    local paths=("/" "/about" "/contact" "/products" "/services" "/blog" "/help")
    echo "${paths[$((RANDOM % ${#paths[@]}))]}"
}

generate_agent() {
    local agents=(
        "Mozilla/5.0"
        "Google Chrome/91.0"
        "Opera/9.80"
        "Safari/14.0"
        "Internet Explorer/11.0"
        "Microsoft Edge/91.0"
        "Crawler and bot"
        "Library and net tool"
    )
    echo "${agents[$((RANDOM % ${#agents[@]}))]}"
}