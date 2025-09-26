.PHONY: run test clean

run:
	@bash src/tls-check.sh google.com 443

test:
	bats tests/

clean:
	rm -f out/*
