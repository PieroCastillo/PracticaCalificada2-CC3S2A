TLS_SRC=src
TLS_TEST=tests
TLS_OUT=out

.PHONY: tls tls-test prepare run test clean

tls: prepare
	bash $(TLS_SRC)/tls-check.sh google.com 443 > $(TLS_OUT)/tls_results.txt

tls-test:
	cd $(TLS_TEST) && bats tls-check.bats

prepare:
	mkdir -p $(TLS_OUT)

run:
	@bash $(TLS_SRC)/tls-check.sh google.com 443

test:
	bats $(TLS_TEST)/

clean:
	rm -f $(TLS_OUT)/*
