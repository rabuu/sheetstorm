alias p := package
alias i := install
alias v := set-version
alias f := format
alias fmt := format

package target *options:
	./scripts/package.sh "{{target}}" {{options}}

install target="local":
	./scripts/package.sh "{{target}}"

set-version version *options:
	./scripts/set-version.sh "{{version}}" {{options}}

format:
	typstyle --inplace .
