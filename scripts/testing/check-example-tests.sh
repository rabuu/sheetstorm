#!/usr/bin/env bash
set -eu

source "$(dirname "$0")/../common.sh"

#
# Checks if every example file has a corresponding test.
#

EXAMPLES_DIR="$PKG_ROOT/examples"
TESTS_DIR="$PKG_ROOT/tests"

failing=0

for f in $(find "$EXAMPLES_DIR" -name '*.typ' -type f); do
	test_file="${f#"$EXAMPLES_DIR/"}"
	test_name="${test_file%.typ}"
	target="$TESTS_DIR/examples/$test_name"

	tmpfile="$(mktemp)"
	sed "s/@preview\/$PKG_NAME:$PKG_VERSION/@local\/$PKG_NAME:$PKG_VERSION/" "$f" > "$tmpfile"

	if [[ ! -f "$target/test.typ" ]]; then
		echo "The example file '$test_file' has no corresponding test."
		failing=$((failing + 1))
		continue
	fi

	if ! cmp --silent "$target/test.typ" "$tmpfile"; then
		echo "The example file '$test_file' doesn't match with its corresponding test."
		failing=$((failing + 1))
		continue
	fi
done

if [[ failing -eq 0 ]]; then
	echo "All example tests are up to date."
fi

exit $failing
