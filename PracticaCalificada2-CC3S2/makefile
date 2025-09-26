HTTP_SRC=src/http
HTTP_TEST=tests
HTTP_OUT=out

.PHONY: http http-test

http: prepare
	bash $(HTTP_SRC)/http_check.sh src/dns/hosts.txt $(HTTP_OUT)/http_results.csv

http-test:
	cd $(HTTP_TEST) && bats http_test.bats

