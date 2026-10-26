#!/bin/sh
# Serves the uploaded «Торговый Путь» static site for the live preview.
if curl -sf -o /dev/null --max-time 1 http://127.0.0.1:8080/; then
  exit 0
fi
cd /workspace/site-preview || exit 1
nohup python3 -m http.server 8080 --bind 0.0.0.0 >/tmp/site-preview.log 2>&1 &
i=0
while [ "$i" -lt 25 ]; do
  if curl -sf -o /dev/null --max-time 1 http://127.0.0.1:8080/; then
    exit 0
  fi
  i=$((i + 1))
  sleep 0.2
done
exit 1
