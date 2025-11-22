alias i := install
alias t := test
alias fmt := format
alias doc := documentation

# For reproducibility, we set the date to 01 January 1980 while testing
date := "315532800"

thumbnail-file := "./tests/examples/assignment/test.typ"

package target *options: clean documentation
	./scripts/package.sh "{{target}}" {{options}}

install target="local": clean
	./scripts/package.sh "{{target}}"

set-version version *options:
	./scripts/set-version.sh "{{version}}" {{options}}

format:
	typstyle --inplace .

check-format:
	typstyle --check .

test $SOURCE_DATE_EPOCH=date: install
	./scripts/testing/check-example-tests.sh
	tt run --no-fail-fast

update-expected $SOURCE_DATE_EPOCH=date: install
	./scripts/testing/update-example-tests.sh
	tt update

clean:
	./scripts/cleanup-artifacts.sh

documentation:
	typst compile docs/manual.typ --root .

thumbnail:
	typst compile --format png --pages 1 "{{thumbnail-file}}" ./thumbnail.png
