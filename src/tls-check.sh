#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-}"
PORT="${2:-443}"

if [[ -z "$HOST" ]]; then
  echo "Uso: $0 <host> [port]" >&2
  exit 2
fi

echo "==> Verificando apertura de socket con nc"
nc -zv "$HOST" "$PORT"

echo "==> Handshake TLS con openssl"
openssl s_client -connect "$HOST:$PORT" </dev/null 2>&1 | grep "Protocol"
