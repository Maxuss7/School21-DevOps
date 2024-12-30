FROM ubuntu:latest

WORKDIR /opt

COPY fastcgi_server.c /opt

RUN apt update -y && \
    apt install -y nginx gcc libfcgi-dev spawn-fcgi && \
    gcc -o fastcgi_server fastcgi_server.c -lfcgi && \
    useradd -r -s /bin/false nginx

COPY nginx.conf /etc/nginx


CMD ["sh", "-c", "spawn-fcgi -p 8080 /opt/fastcgi_server && nginx -g 'daemon off;'"]
