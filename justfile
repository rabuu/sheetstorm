alias p := package
alias i := install
alias v := set-version
alias f := format
alias fmt := format
alias t := test
alias doc := documentation

# For reproducibility, it is now 01 January 1980
export SOURCE_DATE_EPOCH := "315532800"

package target *options: clean
	./scripts/package.sh "{{target}}" {{options}}

install target="local": clean
	./scripts/package.sh "{{target}}"

set-version version *options:
	./scripts/set-version.sh "{{version}}" {{options}}

format:
	typstyle --inplace .

check-format:
	typstyle --check .

test: install
	./scripts/testing/check-example-tests.sh
	tt run --no-fail-fast

update-expected: install
	./scripts/testing/update-example-tests.sh
	tt update

clean:
	./scripts/cleanup-artifacts.sh

documentation:
	typst compile docs/manual.typ --root .
