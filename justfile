alias p := package
alias i := install
alias v := set-version

package target *options:
	./scripts/package.sh "{{target}}" {{options}}

install target="local":
	./scripts/package.sh "{{target}}"

set-version version *options:
	./scripts/set-version.sh "{{version}}" {{options}}
