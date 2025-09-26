#!/usr/bin/env bats

@test "Conexión TCP abre en google.com:443" {
  run src/tls-check.sh google.com 443
  [ "$status" -eq 0 ]
}

@test "Falla en puerto incorrecto" {
  run src/tls-check.sh google.com 444 || true
  [ "$status" -ne 0 ]
}
