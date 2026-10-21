FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache ca-certificates wget unzip \
 && wget -q -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && unzip -o /tmp/xray.zip -d /app && chmod +x /app/xray && rm /tmp/xray.zip \
 && wget -q -O /tmp/usque.zip https://github.com/Diniboy1123/usque/releases/download/v4.2.1/usque_4.2.1_linux_amd64.zip \
 && unzip -o /tmp/usque.zip -d /app && chmod +x /app/usque && rm /tmp/usque.zip
COPY config.json /app/config.json
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
