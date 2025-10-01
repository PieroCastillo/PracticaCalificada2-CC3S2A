# Variables de rutas
DNS_SRC=src/dns
DNS_TEST=tests
DNS_OUT=out

HTTP_SRC=src
HTTP_TEST=tests
HTTP_OUT=out

TLS_SRC=src
TLS_TEST=tests
TLS_OUT=out

.PHONY: http http-test

http: prepare
	bash $(HTTP_SRC)/http_check.sh src/dns/hosts.txt $(HTTP_OUT)/http_results.csv

http-test:
	cd $(HTTP_TEST) && bats http_test.bats

.PHONY: dns dns-test clean prepare

# Target para crear el directorio de salida si no existe
prepare:
	mkdir -p $(DNS_OUT) $(TLS_OUT)

# Ejecuta el script de resolución DNS
dns: prepare
	bash $(DNS_SRC)/resolve.sh $(DNS_SRC)/hosts.txt $(DNS_OUT)/dns_results.csv

# Ejecuta los tests de DNS con Bats
dns-test:
	cd $(DNS_TEST) && bats dns_test.sh

# Limpia los resultados generados
clean:
	rm -f $(DNS_OUT)/dns_results.csv $(DNS_TEST)/results_test.csv $(DNS_TEST)/hosts_test.txt $(TLS_OUT)/*
  
.PHONY: tls tls-test prepare run test clean

tls: prepare
	bash $(TLS_SRC)/tls-check.sh google.com 443 > $(TLS_OUT)/tls_results.txt

tls-test:
	cd $(TLS_TEST) && bats tls-check.bats

run:
	@bash $(TLS_SRC)/tls-check.sh google.com 443

test:
	bats $(TLS_TEST)/
	
