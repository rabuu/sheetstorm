#!/usr/bin/env bash
set -eu

source "$(dirname "$0")/../common.sh"

#
# Checks if every example file has a directory in tests/examples.
#

EXAMPLES_DIR="$PKG_ROOT/examples"
TESTS_DIR="$PKG_ROOT/tests"

missing=0

for f in $(find "$EXAMPLES_DIR" -name '*.typ' -type f); do
	test_file="${f#"$EXAMPLES_DIR/"}"
	test_name="${test_file%.typ}"
	target="$TESTS_DIR/examples/$test_name"

	if [[ ! -d "$target" ]]; then
		echo "The example file '$test_file' has no corresponding test."
		missing=$((missing + 1))
	fi
done

if [[ missing -eq 0 ]]; then
	echo "Every example file has a corresponding test."
fi

exit $missing
