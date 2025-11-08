#!/usr/bin/env bash
set -eu

#
# See <https://github.com/cetz-package/common/blob/main/scripts/package>
#

# What files to include in package
files=(
	src/
	examples/
	template/
	typst.toml
	README.md
	LICENSE
	thumbnail.png
)

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

if [[ "$OSTYPE" == "linux"* ]]; then
	DATA_DIR="${XDG_DATA_DIR:-$HOME/.local/share}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	DATA_DIR="$HOME/Library/Application Support"
else
	DATA_DIR="${APPDATA}"
fi
DATA_DIR="${TYPST_PACKAGE_PATH:-${DATA_DIR}/typst/packages}"

function usage() {
	echo "package.sh TARGET [--version VERSION]"
	echo
	echo "Install relevant files to 'TARGET/$PKG_NAME/$PKG_VERSION'."
	echo "Set TARGET to local to install to local Typst package cache."
}

if (( $# < 1 )); then
	usage
	exit 1
fi

if [[ "${1:-}" == "help" ]] || [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
	usage
	exit 0
fi

TARGET="${1:?Missing target path or @local}"; shift

if [[ "$TARGET" == "@local" ]] || [[ "$TARGET" == "local" ]]; then
	TARGET="${DATA_DIR}/local"
fi

while [[ $# -gt 0 ]]; do
	case "$1" in
		--version | -v)
			shift
			PKG_VERSION="${1:?No version specified}"
			shift
			;;
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

echo "Package root:      $PKG_ROOT"
echo "Package name:      $PKG_NAME"
echo "Package version:   $PKG_VERSION"
echo "Install directory: $TARGET"

TMP="$(mktemp -d)"

for f in "${files[@]}"; do
	mkdir -p "$TMP/$(dirname "$f")" 2>/dev/null
	cp -r "$PKG_ROOT/$f" "$TMP/$f"
done

ACTUAL_TARGET="${TARGET:?}/${PKG_NAME:?}/${PKG_VERSION:?}"
if rm -rf "${ACTUAL_TARGET:?}" 2>/dev/null; then
	echo "Overwriting existing version."
fi

mkdir -p "$ACTUAL_TARGET"
mv "$TMP"/* "$ACTUAL_TARGET"

echo "Successfully packaged to: $ACTUAL_TARGET"
