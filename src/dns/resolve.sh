#!/usr/bin/env bash
set -euo pipefail

INPUT_FILE="${1:-hosts.txt}"
OUTPUT_FILE="${2:-dns_results.csv}"

echo "host,type,value" > "$OUTPUT_FILE"

# Leer todos los hosts válidos en un array para evitar saltarse el último
mapfile -t hosts < <(grep -vE '^#|^$' "$INPUT_FILE")
total=${#hosts[@]}

for i in "${!hosts[@]}"; do
  host="${hosts[$i]}"
  num=$((i + 1))
  printf "[%d de %d] Resolviendo %s...\n" "$num" "$total" "$host"

  cname=""
  # Buscar registros A
  if dig +short A "$host" | grep -qE '^[0-9]+\.'; then
    for ip in $(dig +short A "$host"); do
      echo "$host,A,$ip" >> "$OUTPUT_FILE"
    done
  fi

  # Buscar registros CNAME
  cname=$(dig +short CNAME "$host" || true)
  if [[ -n "$cname" ]]; then
    echo "$host,CNAME,$cname" >> "$OUTPUT_FILE"
  fi

  # Si no hay registros
  if ! dig +short A "$host" | grep -qE '^[0-9]+\.' && [[ -z "$cname" ]]; then
    echo "$host,NONE,NO_RECORD" >> "$OUTPUT_FILE"
  fi
done

echo "Resolución DNS completada para $total dominios."