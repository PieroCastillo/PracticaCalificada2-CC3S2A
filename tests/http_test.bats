#!/usr/bin/env bats

setup() {
  mkdir -p tmp
  echo "google.com" > tmp/hosts_http.txt
  echo "noexiste.dominio" >> tmp/hosts_http.txt
}

teardown() {
  rm -rf tmp out/http_results.csv
}

@test "Dominio válido responde con 200" {
  run bash src/http/http_check.sh tmp/hosts_http.txt out/http_results.csv
  [ "$status" -eq 0 ]
  grep -q "google.com,200" out/http_results.csv
}

@test "Dominio inválido falla en contrato" {
  run bash src/http/http_check.sh tmp/hosts_http.txt out/http_results.csv
  [ "$status" -eq 0 ]
  grep -q "noexiste.dominio,NO_RESPONSE" out/http_results.csv
}
