# Variables de rutas
DNS_SRC=src/dns
DNS_TEST=tests
DNS_OUT=out

.PHONY: dns dns-test clean prepare

# Target para crear el directorio de salida si no existe
prepare:
	mkdir -p $(DNS_OUT)

# Ejecuta el script de resolución DNS
dns: prepare
	bash $(DNS_SRC)/resolve.sh $(DNS_SRC)/hosts.txt $(DNS_OUT)/dns_results.csv

# Ejecuta los tests de DNS con Bats
dns-test:
	cd $(DNS_TEST) && bats dns_test.sh

# Limpia los resultados generados
clean:
	rm -f $(DNS_OUT)/dns_results.csv $(DNS_TEST)/results_test.csv $(DNS_TEST)/hosts_test.txt