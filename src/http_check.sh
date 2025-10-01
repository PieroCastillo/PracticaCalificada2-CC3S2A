Crear .sh
#!/usr/bin/env bash
set -euo pipefail

INPUT_FILE="${1:-src/dns/hosts.txt}"
OUTPUT_FILE="${2:-out/http_results.csv}"


mapfile -t hosts < <(grep -vE '^#|^$' "$INPUT_FILE")
total=${#hosts[@]}

for i in "${!hosts[@]}"; do
  host="${hosts[$i]}"
  num=$((i + 1))
  printf "[%d de %d] Probando HTTP en %s...\n" "$num" "$total" "$host"

  # Intentar petición HTTPS con timeout de 5s
  response=$(curl -skL --max-time 5 -o /dev/null -w "%{http_code}" "https://$host" || true)

  if [[ -z "$response" ]]; then
    echo "$host,NO_RESPONSE,NONE,FAIL" >> "$OUTPUT_FILE"
    continue
  fi

  status_code=$(echo "$response" | cut -d, -f1)
  #content_type=$(echo "$response" | cut -d, -f2)

  # Contrato: status 200 y content-type presente
  if [[ "$status_code" == "200" ]]; then
    echo "$host,200" >> "$OUTPUT_FILE"
  else
    echo "$host,NO_RESPONSE" >> "$OUTPUT_FILE"
  fi
done

echo "Validación HTTP completada para $total dominios."
