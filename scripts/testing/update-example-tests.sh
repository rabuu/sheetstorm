#!/usr/bin/env bash
set -eu

source "$(dirname "$0")/../common.sh"

#
# If an example has no corresponding test, create it.
# If there is a corresponding test, update it.
#

EXAMPLES_DIR="$PKG_ROOT/examples"
TESTS_DIR="$PKG_ROOT/tests"

for f in $(find "$EXAMPLES_DIR" -name '*.typ' -type f); do
	test_file="${f#"$EXAMPLES_DIR/"}"
	test_name="${test_file%.typ}"
	target="$TESTS_DIR/examples/$test_name"

	if [ ! -d "$target" ]; then
		tt new "examples/$test_name"
	fi

	sed "s/@preview\/$PKG_NAME:$PKG_VERSION/@local\/$PKG_NAME:$PKG_VERSION/" "$f" > "$target/test.typ"
done
