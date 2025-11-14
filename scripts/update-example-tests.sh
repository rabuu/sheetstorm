#!/usr/bin/env bash
set -eu

source "$(dirname "$0")/common.sh"

for f in $(find "$PKG_ROOT"/examples -name '*.typ' -type f); do
	real_example_dir="$(realpath "$(dirname "$f")")"
	real_root_dir="$(realpath "$PKG_ROOT")"
	test_name="$(basename "$f")"
	test_name="${test_name%.typ}"
	testdir="$PKG_ROOT/tests/${real_example_dir#"$real_root_dir"}/$test_name"
	mkdir -p "$testdir"
	sed "s/@preview\/$PKG_NAME:$PKG_VERSION/@local\/$PKG_NAME:$PKG_VERSION/" "$f" > "$testdir/test.typ"
done
