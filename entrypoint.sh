#!/bin/sh
cd /app
if [ ! -f /app/usque-config.json ]; then
  echo "registering WARP (MASQUE) device..."
  ./usque -c /app/usque-config.json register --accept-tos -n render-warp || echo "usque register failed, will retry on next start"
fi
echo "starting usque socks on 127.0.0.1:40000 ..."
if [ "$USQUE_HTTP2" = "1" ]; then EXTRA="--http2"; else EXTRA=""; fi
./usque -c /app/usque-config.json socks -b 127.0.0.1 -p 40000 --always-reconnect $EXTRA &
for i in $(seq 1 30); do
  if wget -q -O /dev/null http://127.0.0.1:40000 2>/dev/null; then break; fi
  sleep 1
done
PORT_VAL="${PORT:-10000}"
sed -i "s/8080/${PORT_VAL}/g" /app/config.json
echo "xray (warp exit) listening on port ${PORT_VAL}"
exec ./xray run -config /app/config.json
