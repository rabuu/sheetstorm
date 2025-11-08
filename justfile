alias p := package
alias i := install

package target *options:
	./scripts/package.sh "{{target}}" {{options}}

install target="local":
	./scripts/package.sh "{{target}}"
