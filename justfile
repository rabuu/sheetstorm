alias p := package
alias i := install
alias v := set-version
alias f := format
alias fmt := format
alias t := test

package target *options:
	./scripts/package.sh "{{target}}" {{options}}

install target="local":
	./scripts/package.sh "{{target}}"

set-version version *options:
	./scripts/set-version.sh "{{version}}" {{options}}

format:
	typstyle --inplace .

test: install
	./scripts/testing/check-example-tests.sh
	tt run

update-expected:
	./scripts/testing/update-example-tests.sh
