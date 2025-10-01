#!/usr/bin/env bash

HOST="$1"
PORT="${2:-443}"

if [ -z "$HOST" ]; then
  echo "Uso: $0 <host> [port]" >&2
  exit 2
fi

echo "==> Verificando apertura de socket con nc"
if nc -zv "$HOST" "$PORT"; then
  echo "Socket abierto correctamente"
  echo "==> Handshake TLS con openssl"
  openssl s_client -connect "$HOST:$PORT" </dev/null 2>&1 | grep -m1 "Protocol" || true
  exit 0
else
  echo "No se pudo abrir el socket" >&2
  exit 3
fi
