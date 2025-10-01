#!/usr/bin/env bats

setup() {
  cp ../src/dns/hosts.txt hosts_test.txt
}

teardown() {
  rm -f results_test.csv hosts_test.txt
}

@test "Resuelve dominio válido (A)" {
  echo "google.com" > hosts_test.txt
  run bash ../src/dns/resolve.sh hosts_test.txt results_test.csv
  [ "$status" -eq 0 ]
  grep -q "google.com,A," results_test.csv
}

@test "Resuelve dominio inexistente" {
  echo "noexiste.dominio" > hosts_test.txt
  run bash ../src/dns/resolve.sh hosts_test.txt results_test.csv
  [ "$status" -eq 0 ]
  grep -q "noexiste.dominio,NONE,NO_RECORD" results_test.csv
}