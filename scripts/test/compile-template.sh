#!/usr/bin/env bash
set -eu

PKG_ROOT="${PKG_ROOT:-${PWD}}"
if [[ ! -f "$PKG_ROOT/typst.toml" ]]; then
	echo "This script must be executed from the package root!"
	echo "Alternatively set PKG_ROOT."
	exit 1
fi

function cleanup() {
	find "$PKG_ROOT/template" -name '*.pdf' -type f \
		-exec rm '{}' \;

	echo 'Cleaned up PDF artifacts'
}

for f in $(find "$PKG_ROOT/template" -name '*.typ' -type f); do
	if ! typst compile "$f"; then
		cleanup
		exit 1
	fi
done

echo 'All template files compiled successfully'
cleanup
