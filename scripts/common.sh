#!/usr/bin/env bash
set -eu

function read-toml() {
	local file="$1"
	local key="$2"
	# Read a key value pair in the format: <key> = "<value>"
	# stripping surrounding quotes.
	perl -lne "print \"\$1\" if /^${key}\\s*=\\s*\"(.*)\"/" < "$file"
}

PKG_ROOT="${PWD}"
if [[ ! -f "$PKG_ROOT/typst.toml" ]]; then
	echo "This script must be executed from the package root!"
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

if [[ "$OSTYPE" == "linux"* ]]; then
	DATA_DIR="${XDG_DATA_DIR:-$HOME/.local/share}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	DATA_DIR="$HOME/Library/Application Support"
else
	DATA_DIR="${APPDATA}"
fi
TYPST_PACKAGE_PATH="${TYPST_PACKAGE_PATH:-${DATA_DIR}/typst/packages}"
