FROM ubuntu:latest

USER root

# Install dependencies and clean up
RUN apt update -y && \
    apt install -y nginx gcc libfcgi-dev spawn-fcgi && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /app 

# Copy configuration files
COPY nginx.conf /etc/nginx
COPY fastcgi_server.c /app

# Set permissions
RUN groupadd -r nginx && useradd -r -g nginx nginx && \
    mkdir -p /var/lib/nginx && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/run/nginx && \
    chown -R nginx:nginx /var/lib/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /app && \
    chown -R nginx:nginx /etc/nginx && \
    chown -R nginx:nginx /var/run/nginx && \
    chmod u-s /usr/bin/gpasswd && \
    chmod u-s /usr/bin/newgrp && \
    chmod u-s /bin/su && \
    chmod u-s /bin/mount && \
    chmod u-s /bin/umount && \
    chmod u-s /usr/bin/chsh && \
    chmod u-s /usr/bin/chfn && \
    chmod ug-s /usr/sbin/pam_extrausers_chkpwd && \
    chmod ug-s /usr/bin/expiry && \
    chmod 755 /usr/bin/wall && \
    chmod 755 /sbin/unix_chkpwd && \
    chmod 755 /usr/bin/chage && \
    chmod 755 /usr/bin/passwd

USER nginx

# Compile the FastCGI server
RUN gcc -o /app/fastcgi_server /app/fastcgi_server.c -lfcgi

HEALTHCHECK --interval=5m --timeout=10s CMD curl -f http://localhost:80 || exit 1

# Run the FastCGI server and nginx
CMD ["sh", "-c", "spawn-fcgi -p 8080 /app/fastcgi_server && nginx -g 'daemon off;'"]
