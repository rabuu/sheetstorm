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

test:
	./scripts/test/compile-examples.sh
	./scripts/test/compile-template.sh
