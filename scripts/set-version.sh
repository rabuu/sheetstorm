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

function usage() {
	echo "set-version.sh VERSION"
	echo
	echo "In .typ files and README.md:"
	echo "Replace every '$PKG_NAME:$PKG_VERSION' with '$PKG_NAME:VERSION'."
	echo
	echo "In typst.toml:"
	echo "Set version to '$PKG_VERSION'."
}

if (( $# < 1 )); then
	usage
	exit 1
fi

if [[ "${1:-}" == "help" ]] || [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
	usage
	exit 0
fi

NEW_VERSION="${1:?Missing target path or @local}"; shift

while [[ $# -gt 0 ]]; do
	case "$1" in
		--help | -h)
			usage
			exit 0
			;;
		*)
			echo "Unexpected option $1!"
			echo
			usage
			exit 1
			;;
	esac
done

echo "Old version: ${PKG_VERSION}"
echo "New version: ${NEW_VERSION}"

find . \( -name '*.typ' -o -name 'README.md' \) -type f \
	-exec sed -i "s/$PKG_NAME:$PKG_VERSION/$PKG_NAME:$NEW_VERSION/" '{}' \;

sed -i "s/version = \"$PKG_VERSION\"/version = \"$NEW_VERSION\"/" typst.toml

if git ls-files | xargs grep -q "$PKG_VERSION"; then
	echo
	echo "There are still some occurences of the string '$PKG_VERSION':"
	echo
	git ls-files | xargs grep "$PKG_VERSION"
fi
