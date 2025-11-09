#!/usr/bin/env bash
set -eu

function read-toml() {
	local file="$1"
	local key="$2"
	# Read a key value pair in the format: <key> = "<value>"
	# stripping surrounding quotes.
	perl -lne "print \"\$1\" if /^${key}\\s*=\\s*\"(.*)\"/" < "$file"
}

PKG_ROOT="${PKG_ROOT:-${PWD}}"
if [[ ! -f "$PKG_ROOT/typst.toml" ]]; then
	echo "This script must be executed from the package root!"
	echo "Alternatively set PKG_ROOT."
	exit 1
fi

PKG_NAME="$(read-toml "$PKG_ROOT/typst.toml" "name")"
if [[ -z "$PKG_NAME" ]]; then
	echo "Could not read 'name' from $PKG_ROOT/typst.toml!"
	exit 1
fi

PKG_VERSION="$(read-toml "$PKG_ROOT/typst.toml" "version")"
if [[ -z "$PKG_VERSION" ]]; then
	echo "Could not read 'version' from $PKG_ROOT/typst.toml!"
	exit 1
fi

for f in $(find "$PKG_ROOT"/examples -name '*.typ' -type f); do
	real_example_dir="$(realpath "$(dirname "$f")")"
	real_root_dir="$(realpath "$PKG_ROOT")"
	test_name="$(basename "$f")"
	test_name="${test_name%.typ}"
	testdir="$PKG_ROOT/tests/${real_example_dir#"$real_root_dir"}/$test_name"
	mkdir -p "$testdir"
	sed "s/@preview\/$PKG_NAME:$PKG_VERSION/@local\/$PKG_NAME:$PKG_VERSION/" "$f" > "$testdir/test.typ"
done
