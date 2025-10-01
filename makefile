TLS_SRC=src
TLS_TEST=tests
TLS_OUT=out

.PHONY: tls tls-test

tls: prepare
	bash $(TLS_SRC)/tls-check.sh google.com 443 > $(TLS_OUT)/tls_results.txt

tls-test:
	cd $(TLS_TEST) && bats tls-check.bats


.PHONY: run test clean

run:
	@bash src/tls-check.sh google.com 443

test:
	bats tests/

clean:
	rm -f out/*
